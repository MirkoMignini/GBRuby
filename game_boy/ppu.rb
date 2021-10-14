require_relative 'sdl2'
require_relative 'video'

class PPU
  include SDL2

  # Mode 00: When the flag is 00 it is the H-Blank
  # period and the CPU can access the display
  # RAM ($8000-$9FFF).
  # Mode 01: When the flag is 01 it is the V-Blank
  # period and the CPU can access the display
  # RAM ($8000-$9FFF).
  # Mode 10: When the flag is 10 then the OAM is being
  # used ($FE00-$FE9F). The CPU cannot access
  # the OAM during this period
  # Mode 11: When the flag is 11 both the OAM and
  # display RAM are being used. The CPU cannot
  # access either during this period.

  # Complete refresh: 456 for a scanline
  # Every: 70_224
  # 456 * 144 = 65664 + 4560 = 70224
  # Clock: 4_194_304
  # 4_194_304 / 70_224 = 59.7275

  # Period	                    GPU mode number	    Time spent (clocks)
  # Scanline (accessing OAM)	        2	                  80
  # Scanline (accessing VRAM)	        3	                  172
  # Horizontal blank	                0	                  204
  # One line (scan and blank)		                          456
  # Vertical blank	                  1	                  4560 (10 lines)
  # Full frame (scans and vblank)		                      70224

  # The LY indicates the vertical line to which the present data is transferred to the LCD
  # Driver. The LY can take on any value between 0 through 153. The values between
  # 144 and 153 indicate the V-Blank period. Writing will reset the counter.

  MODE_MASK = 0b11111100.freeze
  MODE_0 = 0.freeze # During H-Blank
  MODE_1 = 1.freeze # During V-Blank
  MODE_2 = 2.freeze # During Searching OAM-RAM
  MODE_3 = 3.freeze # During Transfering Data to LCD Driver

  SCREEN_WIDTH = 160.freeze
  SCREEN_HEIGHT = 144.freeze

  MODE_2_LIMIT = 80.freeze
  MODE_3_LIMIT = 252.freeze
  MODE_0_LIMIT = 456.freeze
  MODE_1_LIMIT = 456.freeze

  # COLORS = [0xFFDAF9CC, 0xFF76C365, 0xFF1b6A55, 0x00031821].freeze
  COLORS = [0xFFFFFFFF, 0xFFAAAAAA, 0xFF555555, 0x00000000].freeze

  LAST_SCANLINE = 153.freeze

  LCDC_DISPLAY_ENABLE              = 128 # Bit 7 - LCD Display Enable             (0=Off, 1=On)
  LCDC_WIN_TILE_MAP_DISPLAY_SELECT = 64  # Bit 6 - Window Tile Map Display Select (0=9800-9BFF, 1=9C00-9FFF)
  LCDC_WIN_DISPLAY_ENABLE          = 32  # Bit 5 - Window Display Enable          (0=Off, 1=On)
  LCDC_BG_WINDOW_TILE_DATA_SELECT  = 16  # Bit 4 - BG & Window Tile Data Select   (0=8800-97FF, 1=8000-8FFF)
  LCDC_BG_TILE_MAP_DISPLAY_SELECT  = 8   # Bit 3 - BG Tile Map Display Select     (0=9800-9BFF, 1=9C00-9FFF)
  LCDC_SPRITE_SIZE                 = 4   # Bit 2 - OBJ (Sprite) Size              (0=8x8, 1=8x16)
  LCDC_SPRITE_DISPLAY_ENABLE       = 2   # Bit 1 - OBJ (Sprite) Display Enable    (0=Off, 1=On)
  LCDC_BG_WINDOW_DISPLAY           = 1   # Bit 0 - BG/Window Display/Priority     (0=Off, 1=On)

  OAM_ADDRESS = 0xFE00.freeze

  SPRITE_ATTRIB_PRIORITY  = 0b10000000.freeze
  SPRITE_ATTRIB_FLIPY     = 0b01000000.freeze
  SPRITE_ATTRIB_FLIPX     = 0b00100000.freeze
  SPRITE_ATTRIB_PALETTE   = 0b00010000.freeze

  attr_reader :window, :video

  def initialize(device)
    @device = device
    @scan_line = 0
    @window_line = 0
    @cycles = 0

    @framebuffer = Array.new(SCREEN_WIDTH * SCREEN_HEIGHT, 0)
    @video = Video.new
  end

  def step(cycles)
    @lcdc = @device.io_registers.lcdc

    # If LCD is disabled does nothing (LCDC bit 7 off)
    return if @lcdc & LCDC_DISPLAY_ENABLE == 0

    @scan_line = @device.io_registers.ly
    @mode = @device.io_registers.lcd_mode

    # updated current cycles
    @cycles += cycles

    if @mode == 0
      # hblank
      return if @cycles < MODE_0_LIMIT

      next_scan_line

      if @scan_line == SCREEN_HEIGHT
        @device.io_registers.lcd_mode = 1
        @cycles = 0
        @device.cpu.request_interrupt(CPU::INTERRUPT_VBLANK)
        render
        @window_line = 0
      else
        @device.io_registers.lcd_mode = 2
        @cycles = 0
      end
    elsif @mode == 1
      if @scan_line == 0
        @device.io_registers.lcd_mode = 2
        @cycles = 0
      end

      # vblank mode
      return if @cycles < MODE_1_LIMIT

      next_scan_line
      @cycles = 0
    elsif @mode == 2
      # Searching OAM-RAM
      return if @cycles < MODE_2_LIMIT

      @device.io_registers.lcd_mode = 3
    else # mode 3
      # Transfering Data to LCD Driver
      return if @cycles < MODE_3_LIMIT

      draw_scan_line if @scan_line < SCREEN_HEIGHT

      @device.io_registers.lcd_mode = 0
    end
  end

  def next_scan_line
    @scan_line = @scan_line == LAST_SCANLINE ? 0 : @scan_line + 1
    @device.io_registers.ly = @scan_line

    if @device.io_registers.lyc == @scan_line
      @device.io_registers.coincidence_flag = 1
      @device.cpu.request_interrupt(CPU::INTERRUPT_LCDSTAT) if @device.io_registers.coincidence_flag_enabled?
    else
      @device.io_registers.coincidence_flag = 0
    end
  end

  def draw_scan_line
    draw_tiles if @lcdc & LCDC_BG_WINDOW_DISPLAY == LCDC_BG_WINDOW_DISPLAY
    draw_window if @lcdc & LCDC_WIN_DISPLAY_ENABLE == LCDC_WIN_DISPLAY_ENABLE
    draw_sprites if @lcdc & LCDC_SPRITE_DISPLAY_ENABLE == LCDC_SPRITE_DISPLAY_ENABLE
  end

  def setup_palette(palette)
    [
      COLORS[palette & 0b00000011],
      COLORS[(palette & 0b00001100) >> 2],
      COLORS[(palette & 0b00110000) >> 4],
      COLORS[(palette & 0b11000000) >> 6]
    ]
  end

  def draw_tiles
    @palette = setup_palette(@device.io_registers.bgp)

    @scroll_x = @device.io_registers.scx
    @scroll_y = @device.io_registers.scy

    @bg_tiles_map_address = (@lcdc & LCDC_BG_TILE_MAP_DISPLAY_SELECT == 0) ? 0x9800 : 0x9C00
    @map_tiles_address = (@lcdc & LCDC_BG_WINDOW_TILE_DATA_SELECT == 0) ? 0x8800 : 0x8000

    # First visible tile
    @tile_x = @scroll_x / 8
    @tile_y = ((@scan_line + @scroll_y) & 0xFF) / 8

    # Screen coordinates
    @screen_x = (@tile_x * 8) - @scroll_x
    @screen_y = @scan_line

    # Framebuffer y offset
    @screen_y_offset = @screen_y * SCREEN_WIDTH

    # Tile y offset
    @tile_y_offset = (((@screen_y + @scroll_y) & 0xFF) % 8) * 2

    # There are max 21 visible horizontal tiles
    21.times do |index|
      # draw tile
      draw_tile

      # go to next tile x
      @tile_x = @tile_x == 31 ? 0 : @tile_x + 1

      # go to next tile screen position
      @screen_x += 8
    end
  end

  def draw_tile
    # get tile at current coordinates
    @tile = @device.vram.read_byte(@bg_tiles_map_address + @tile_x + (@tile_y << 5))

    # get tile base address
    tile_address = if @map_tiles_address == 0x8000
      0x8000 + @tile_y_offset + (@tile << 4)
    else
      0x8800 + @tile_y_offset + ((signed_byte(@tile) + 128) << 4)
    end

    # get tile bytes
    byte0, byte1 = @device.vram.read_memory(tile_address, 2)

    # draw 8 pixel of this tile
    8.times do |index|
      # calculate final x screen coordinates
      x = @screen_x + index

      # skip if out of screen
      next if x < 0
      break if x >= 160

      # get color
      offset = 7 - index
      shift = 1 << offset
      color = ((byte0 & shift) >> offset) +
              ((byte1 & shift) >> (offset - 1))

      # # update framebuffer
      @framebuffer[@screen_y_offset + x] = @palette[color]
    end
  end

  def draw_window
    @window_y = @device.io_registers.wy
    @window_x = @device.io_registers.wx

    return unless (@window_x <= 166 && @window_y <= 143 && @window_line <= 143 && @scan_line >= @window_y)

    @window_x -= 7

    @map_tiles_address = (@lcdc & LCDC_BG_WINDOW_TILE_DATA_SELECT == 0) ? 0x8800 : 0x8000
    @win_tiles_map_address = (@lcdc & LCDC_WIN_TILE_MAP_DISPLAY_SELECT == 0) ? 0x9800 : 0x9C00

    tile_y = (@window_line >> 3) & 0x1F

    21.times do |tile_x|
      next if (tile_x * 8 < @window_x)

      tile_x = (tile_x * 8 - @window_x) / 8

      tile = @device.vram.read_byte(@win_tiles_map_address + tile_x + (tile_y << 5))

      scan_line_offset = (@window_line - @window_y) % 8 * 2

      address = if @map_tiles_address == 0x8000
        0x8000 + scan_line_offset + (tile << 4)
      else
        0x8800 + scan_line_offset + ((signed_byte(tile) + 128) << 4)
      end

      bytes = @device.vram.read_memory(address, 2)

      8.times do |index|
        x = tile_x * 8 + @window_x + index

        # skip if out of screen
        next if x < 0
        break if x >= 160

        shift = 1.lshift8(7 - index)
        color = (bytes[0] & shift).rshift8(7 - index) +
                (bytes[1] & shift).rshift8(6 - index)

        @framebuffer[@scan_line * SCREEN_WIDTH + x] = COLORS[color]
      end
    end

    @window_line += 1
  end

  def signed_byte(value)
    value > 127 ? -256 + value : value
  end

  def draw_sprites
    sprite_height = (@lcdc & LCDC_SPRITE_SIZE == 0) ? 8 : 16
    sprites_per_line = 0

    sprites = []

    40.times do |index|
      sprite_address = OAM_ADDRESS + index * 4
      pos_y = @device.oam.read_byte(sprite_address) - 16

      next unless ((@scan_line >= pos_y) && (@scan_line < (pos_y + sprite_height)))

      pos_x = @device.oam.read_byte(sprite_address + 1) - 8

      sprites << {
        address: sprite_address,
        pos_y: pos_y,
        pos_x: pos_x
      }

      # Max 10 objects per scanline
      sprites_per_line += 1
      break if sprites_per_line == 10
    end

    # the smaller the X coordinate, the higher the priority.
    # When X coordinates are identical, the object located first
    # in OAM has higher priority.
    sprites.sort_by! { |s| [-s[:pos_x], -s[:address]] }

    sprites.each do |sprite|
      tile = @device.oam.read_byte(sprite[:address] + 2)
      # Bit 0 of tile index for 8x16 objects should be ignored
      tile &= 0b11111110 if sprite_height == 16

      attributes = @device.oam.read_byte(sprite[:address] + 3)

      flip_y = attributes & SPRITE_ATTRIB_FLIPY == SPRITE_ATTRIB_FLIPY
      flip_x = attributes & SPRITE_ATTRIB_FLIPX == SPRITE_ATTRIB_FLIPX
      priority = attributes & SPRITE_ATTRIB_PRIORITY == SPRITE_ATTRIB_PRIORITY
      palette = setup_palette((attributes & SPRITE_ATTRIB_PALETTE) == SPRITE_ATTRIB_PALETTE ? @device.io_registers.obp1 : @device.io_registers.obp0)

      offset = @scan_line - sprite[:pos_y]
      offset = sprite_height - offset - 1 if flip_y
      address = 0x8000 + (tile * 16) + (offset * 2)

      byte0, byte1 = @device.vram.read_memory(address, 2)
      frame_buffer_address = @scan_line * SCREEN_WIDTH + sprite[:pos_x]

      8.times do |x|
        screen_pos_x = sprite[:pos_x] + x
        next if screen_pos_x < 0
        break if screen_pos_x >= 160

        flip_offset = flip_x ? 7 - x : x
        shift = 1 << (7 - flip_offset)
        color = ((byte0 & shift) >> (7 - flip_offset)) +
                ((byte1 & shift) >> (6 - flip_offset))

        position = frame_buffer_address + x

        next if color == 0 || (priority && @framebuffer[position] != palette[0])

        @framebuffer[position] = palette[color]
      end
    end
  end

  def render
    @video.render(@framebuffer)
    @device.input.step
    # FOR DEBUG ONLY
    # @framebuffer = Array.new(SCREEN_WIDTH * SCREEN_HEIGHT, 0xFFFF0000)
  end

  def dispose
    @video.dispose
  end
end
