require_relative 'cartridge/chip'
require_relative 'cartridge/header'
require_relative 'cartridge/mbc1'

class Cartridge
  attr_reader :chip, :header

  def initialize(filename)
    @bytes = File.open(filename, 'rb').read.bytes
    @header = Header.new(@bytes)

    init_chip
  end

  def init_chip
    case @header.cartridge_type
    when 0
      @chip = Chip.new(self, @bytes)
    when 1, 2, 3
      @chip = Mbc1.new(self, @bytes)
    else
      raise NotImplementedError.new('Cartridge type %02X not supported yet.' % [@header.cartridge_type])
    end
  end

  def read_rom_byte(address)
    @chip.read_rom_byte(address)
  end

  def read_ram_byte(address)
    @chip.read_ram_byte(address)
  end

  def read_rom_word(address)
    @chip.read_rom_word(address)
  end

  def read_ram_word(address)
    @chip.read_ram_word(address)
  end

  def read_ram_memory(address, size)
    @chip.read_ram_memory(address, size)
  end

  def write_rom_byte(address, value)
    @chip.write_rom_byte(address, value)
  end

  def write_ram_byte(address, value)
    @chip.write_ram_byte(address, value)
  end
end
