require_relative 'memory'

class IORegisters < Memory
  # FF00..FF7F  I/O Registers

  JOYP  = 0x00.freeze
  SC    = 0x02.freeze
  DIV   = 0x04.freeze
  TIMA  = 0x05.freeze
  TMA   = 0x06.freeze
  TAC   = 0x07.freeze
  IF    = 0x0F.freeze
  LCDC  = 0x40.freeze
  STAT  = 0x41.freeze
  SCY   = 0x42.freeze
  SCX   = 0x43.freeze
  LY    = 0x44.freeze
  LYC   = 0x45.freeze
  DMA   = 0x46.freeze
  BGP   = 0x47.freeze
  OBP0  = 0x48.freeze
  OBP1  = 0x49.freeze
  WY    = 0x4A.freeze
  WX    = 0x4B.freeze

  def initialize(device)
    super(0x80, 0xFF00, device)
  end

  def set(address, value)
    @memory[address] = value
  end

  def get(address)
    @memory[address]
  end

  def inc(address, value = 1)
    @memory[address] = @memory[address] + value & 0xFF
  end

  def lcd_mode=(mode)
    case mode
    when 0 then @memory[STAT] &= 0b11111100
    when 1 then @memory[STAT] = @memory[STAT] & 0b11111100 | 0b00000001
    when 2 then @memory[STAT] = @memory[STAT] & 0b11111100 | 0b00000010
    when 3 then @memory[STAT] |= 0b00000011
    end
  end

  def lcdc
    @memory[LCDC]
  end

  def ly
    @memory[LY]
  end

  def lcd_mode
    @memory[STAT] & 0b00000011
  end

  def coincidence_flag=(value)
    (value == 1 || value) ? @memory[STAT] |= 0b00000100 : @memory[STAT] &= ~0b11111011
  end

  def coincidence_flag
    @memory[STAT] & 0b00000100
  end

  def coincidence_flag_enabled?
    @memory[STAT] & 0b01000000 == 0b01000000
  end

  def read_byte(address)
    if address == 0xFF00
      @device.input.read_keyboard(@memory[JOYP])
    else
      @memory[address - @offset]
    end
  end

  def write_byte(address, value)
    if (address - @offset == SC && value == 0x81)
      print @memory[1].chr
      @memory[address - @offset] = value
    # writing any value to DIV sets it to $00
    elsif (address - @offset == DIV)
      @memory[address - @offset] = 0
    elsif (address - @offset == TAC)
      @device.timer.setup(value)
      @memory[address - @offset] = value
    # TODO: check if is true
    # reset the current scanline if the game tries to write to it
    # elsif (address == 0xFF44)
    #   @memory[address - @offset] = 0
    elsif (address - @offset == STAT)
      # bits 0-2 are read-only
      @memory[address - @offset] = (value & 0xf8) | (memory[address - @offset] & 0x07);
    elsif (address - @offset == DMA)
      @device.oam.dma(value)
    else
      @memory[address - @offset] = value
    end
  end
end
