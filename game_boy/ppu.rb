# require_relative 'sdl'
# require_relative 'screen'

class PPU
  # include SDL
  # screen 160 x 144

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

  # The Mode Flag goes through the values 0, 2,
  # and 3 at a cycle of about 109uS. 0 is present
  # about 48.6uS, 2 about 19uS, and 3 about 41uS.
  # This is interrupted every 16.6ms by the VBlank
  # (1). The mode flag stays set at 1 for about 1.08
  # ms. (Mode 0 is present between 201-207 clks, 2
  # about 77-83 clks, and 3 about 169-175 clks. A
  # complete cycle through these states takes 456
  # clks. VBlank lasts 4560 clks. A complete screen
  # refresh occurs every 70224 clks.)

  # The screen resolution is 160x144 meaning there are 144 visible scanlines.
  # The Gameboy draws each scanline one at a time starting from 0 to 153,
  # this means there are 144 visible scanlines and 8 invisible scanlines.
  # When the current scanline is between 144 and 153 this is the vertical blank period.
  # The current scanline is stored in register address 0xFF44.
  # The pandocs tell us that it takes 456 cpu clock cycles to draw one scanline

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

  # STAT shows the current status of the LCD controller.
  STAT = 0x41

  # The LY indicates the vertical line to which the present data is transferred to the LCD
  # Driver. The LY can take on any value between 0 through 153. The values between
  # 144 and 153 indicate the V-Blank period. Writing will reset the counter.

  # The LYC compares itself with the LY.
  # If the values are the same it causes the STAT to set the coincident flag.
  LYC = 0x45

  MODE_MASK = 0b11111100
  MODE_0 = 0 # During H-Blank
  MODE_1 = 1 # During V-Blank
  MODE_2 = 2 # During Searching OAM-RAM
  MODE_3 = 3 # During Transfering Data to LCD Driver

  # WINDOW_WIDTH = 480
  # WINDOW_HEIGHT = 432

  SCREEN_WIDTH = 160
  SCREEN_HEIGHT = 144

  MODE_2_LIMIT = 80
  MODE_3_LIMIT = 252
  MODE_0_LIMIT = 456
  MODE_1_LIMIT = 456

  LAST_SCANLINE = 153

  LCDC_DISPLAY_ENABLE              = 128 # Bit 7 - LCD Display Enable             (0=Off, 1=On)
  LCDC_WIN_TILE_MAP_DISPLAY_SELECT = 64  # Bit 6 - Window Tile Map Display Select (0=9800-9BFF, 1=9C00-9FFF)
  LCDC_WIN_DISPLAY_ENABLE          = 32  # Bit 5 - Window Display Enable          (0=Off, 1=On)
  LCDC_BG_WINDOW_TILE_DATA_SELECT  = 16  # Bit 4 - BG & Window Tile Data Select   (0=8800-97FF, 1=8000-8FFF)
  LCDC_BG_TILE_MAP_DISPLAY_SELECT  = 8   # Bit 3 - BG Tile Map Display Select     (0=9800-9BFF, 1=9C00-9FFF)
  LCDC_SPRITE_SIZE                 = 4   # Bit 2 - OBJ (Sprite) Size              (0=8x8, 1=8x16)
  LCDC_SPRITE_DISPLAY_ENABLE       = 2   # Bit 1 - OBJ (Sprite) Display Enable    (0=Off, 1=On)
  LCDC_BG_WINDOW_DISPLAY           = 1   # Bit 0 - BG/Window Display/Priority     (0=Off, 1=On)

  attr_reader :window

  def initialize(device)
    @device = device
    @scan_line = 0
    @cycles = 0

    # @framebuffer = Array.new SCREEN_WIDTH * SCREEN_HEIGHT, 0

    @window = SDL2::Window.create("GBRuby", 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, SDL2::Window::Flags::RESIZABLE)
    @renderer = @window.create_renderer(-1, SDL2::Renderer::Flags::ACCELERATED)
    @renderer.logical_size =  [SCREEN_WIDTH, SCREEN_HEIGHT]
    @last = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    # @screen = Screen.new
  end

  def step(cycles)
    @lcdc = @device.io_registers.get(IORegisters::LCDC)

    # If LCD is disabled does nothing (LCDC bit 7 off)
    return if @lcdc & LCDC_DISPLAY_ENABLE == 0
    #   # reset current scan line
    #   @device.io_registers.set(IORegisters::LY, @scan_line = 0)
    #   # set mode 0
    #   @device.io_registers.set(IORegisters::STAT, @stat_register & 0b11111100)
    #   # reset cycles
    #   @cycles = 0
    #   return
    # end

    @scan_line = @device.io_registers.get(IORegisters::LY)
    @mode = @device.io_registers.lcd_mode

    # puts ("Cycles: #{@cycles} - Mode: #{@mode} - line: #{@scan_line}")

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
    @device.io_registers.set(IORegisters::LY, @scan_line)

    if @device.io_registers.get(IORegisters::LYC) == @scan_line
      @device.io_registers.coincidence_flag = 1
      @device.cpu.request_interrupt(CPU::INTERRUPT_LCDSTAT) if @device.io_registers.coincidence_flag_enabled?
    else
      @device.io_registers.coincidence_flag = 0
    end
  end

  def draw_scan_line
    draw_tiles if @lcdc & LCDC_BG_WINDOW_DISPLAY == LCDC_BG_WINDOW_DISPLAY
    # draw_window
    # draw_sprites if @lcdc & LCDC_SPRITE_DISPLAY_ENABLE == LCDC_SPRITE_DISPLAY_ENABLE
  end

  def draw_tiles
    @scroll_x = @device.io_registers.get(IORegisters::SCX)
    @scroll_y = @device.io_registers.get(IORegisters::SCY)
    @map_tiles_map_address = (@lcdc & LCDC_BG_TILE_MAP_DISPLAY_SELECT == 0) ? 0x9800 : 0x9C00
    @map_tiles_address = (@lcdc & LCDC_BG_WINDOW_TILE_DATA_SELECT == 0) ? 0x8800 : 0x8000

    tile_y = (@scan_line + @scroll_y) / 8

    32.times do |tile_x|
      tile = @device.read_byte(@map_tiles_map_address + tile_x + tile_y * 32)
      draw_tile(tile, tile_x)
    end
  end

  def signed_byte(value)
    value > 127 ? -256 + value : value
  end

  def draw_tile(tile, tile_x)
    address = if @map_tiles_address == 0x8000
      0x8000 + (tile * 16)
    else
      0x8800 + (signed_byte(tile) + 128) * 16
    end
    scan_line_offset = @scan_line % 8 * 2
    byte_1 = @device.read_byte(address + scan_line_offset)
    byte_2 = @device.read_byte(address + scan_line_offset + 1)

    8.times do |index|
      x = tile_x * 8 + index

      next if x < 0 || x > SCREEN_WIDTH

      shift = 1 << (7 - index)
      color = (byte_1 & shift).rshift8(6 - index) +
              (byte_2 & shift).rshift8(7 - index)
      # color = ((byte_1 & shift) >> (6 - index)) +
      #         ((byte_2 & shift) >> (7 - index))

      @renderer.draw_color = rgb_color(color)
      @renderer.draw_point(x, @scan_line)
      # @framebuffer[@scan_line * SCREEN_WIDTH + (tile_x * 8 + index)] if tile_x * 8 + index >= 0 && tile_x * 8 + index < SCREEN_WIDTH
    end
  end

  def draw_window
    @window_x = @device.io_registers.get(IORegisters::WX) - 7
    @window_y = @device.io_registers.get(IORegisters::WY)

    @window_tiles_address = (@lcdc & LCDC_BG_WINDOW_TILE_DATA_SELECT == 0) ? 0x8800 : 0x8000

    tile_y = (@scan_line + @scroll_y) / 8
    32.times do |tile_x|
      tile = @device.read_byte(@window_tiles_address + tile_x + tile_y * 32)
      draw_tile(tile, tile_x)
    end
  end

  def draw_sprites
    # TODO
  end

  def rgb_color(gb_color)
    # if gb_color == 3
    #   [0x00, 0x00, 0x00]
    # elsif gb_color == 2
    #   [0xAA, 0xAA, 0xAA]
    # elsif gb_color == 1
    #   [0x55, 0x55, 0x55]
    # else
    #   [0xFF, 0xFF, 0xFF]
    # end
    case gb_color
    when 3 then [0x00, 0x00, 0x00]
    when 2 then [0xAA, 0xAA, 0xAA]
    when 1 then [0x55, 0x55, 0x55]
    when 0 then [0xFF, 0xFF, 0xFF]
    else
      raise StandardError.new("Color #{gb_color} not allowed.")
    end
  end

  def render
    # @screen.render(@framebuffer)
    @renderer.present
    @renderer.clear

    event = SDL2::Event.poll
    case event
    when SDL2::Event::Quit
      exit
    end

    t = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    fps = 1.0 / (t - @last)
    fps = fps.floor(2).to_s
    @last = t

    @window.title = "#{fps} fps"
  end
end
