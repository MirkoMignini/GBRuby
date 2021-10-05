class Cartridge
  # 0x0000..0x7FFF  16KB ROM
  # 0xA000..0xBFFF  8KB RAM

  ROM_LIMIT = 0x7FFF
  RAM_OFFSET = 0xA000

  attr_reader :rom, :ram

  def initialize(filename)
    @rom = Array.new(0x8000) { 0x0 }
    @ram = Array.new(0x2000) { 0x0 }

    contents = File.open(filename, 'rb').read
    @rom[0, contents.size] = contents.bytes
  end

  def read_rom_byte(address)
    @rom[address]
  end

  def read_ram_byte(address)
    @ram[address - RAM_OFFSET]
  end

  def read_rom_word(address)
    (@rom[address + 1] << 8) + @rom[address]
  end

  def read_ram_word(address)
    (@ram[address - RAM_OFFSET + 1] << 8) + @ram[address - RAM_OFFSET]
  end

  def write_rom_byte(address, value)
    # @rom[address] = value
  end

  def write_ram_byte(address, value)
    @ram[address - RAM_OFFSET] = value
  end
end
