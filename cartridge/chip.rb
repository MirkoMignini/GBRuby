class Chip
  RAM_OFFSET = 0xA000
  RAM_BANK_SIZE = 0x2000
  ROM_BANK_SIZE = 0x4000

  attr_reader :rom, :ram, :cartridge

  def initialize(cartridge, bytes)
    @rom = Array.new(cartridge.header.rom_size) { 0x0 }
    @ram = Array.new(cartridge.header.ram_size) { 0x0 }

    @rom[0, bytes.size] = bytes
  end

  def read_rom_byte(address)
    @rom[address]
  end

  def read_rom_word(address)
    (read_rom_byte(address + 1) << 8) + read_rom_byte(address)
  end

  def write_rom_byte(address, value)
  end

  def read_ram_byte(address)
    @ram[address - RAM_OFFSET]
  end

  def read_ram_word(address)
    (read_ram_byte(address + 1) << 8) + read_ram_byte(address)
  end

  def read_ram_memory(address, size)
    @ram[address - RAM_OFFSET, size]
  end

  def write_ram_byte(address, value)
    @ram[address - RAM_OFFSET] = value
  end
end
