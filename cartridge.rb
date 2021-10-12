require_relative 'cartridge/chip'
require_relative 'cartridge/mbc1'

class Cartridge
  attr_reader :chip

  def initialize(filename)
    @bytes = File.open(filename, 'rb').read.bytes

    init_chip
  end

  def init_chip
    case cartridge_type
    when 0
      @chip = Chip.new(self, @bytes)
    when 1, 2, 3
      @chip = Mbc1.new(self, @bytes)
    else
      raise NotImplementedError.new('Cartridge type %02X not supported yet.' % [cartridge_type])
    end
  end

  def cartridge_type
    @bytes[0x147]
  end

  def rom_size
    case @bytes[0x148]
    when 0x00 then Chip::ROM_BANK_SIZE * 2
    when 0x01 then Chip::ROM_BANK_SIZE * 4
    when 0x02	then Chip::ROM_BANK_SIZE * 8
    when 0x03	then Chip::ROM_BANK_SIZE * 16
    when 0x04	then Chip::ROM_BANK_SIZE * 32
    when 0x05	then Chip::ROM_BANK_SIZE * 64
    when 0x06	then Chip::ROM_BANK_SIZE * 128
    when 0x07	then Chip::ROM_BANK_SIZE * 256
    when 0x08	then Chip::ROM_BANK_SIZE * 512
    when 0x52	then Chip::ROM_BANK_SIZE * 72
    when 0x53	then Chip::ROM_BANK_SIZE * 80
    when 0x54	then Chip::ROM_BANK_SIZE * 96
    end
  end

  def ram_size
    case @bytes[0x149]
    when 0x00 then Chip::RAM_BANK_SIZE * 0
    when 0x01 then Chip::RAM_BANK_SIZE * 0
    when 0x02 then Chip::RAM_BANK_SIZE * 1
    when 0x03 then Chip::RAM_BANK_SIZE * 4
    when 0x04 then Chip::RAM_BANK_SIZE * 16
    when 0x05 then Chip::RAM_BANK_SIZE * 8
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
