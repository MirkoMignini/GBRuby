require_relative 'chip'

class Mbc1 < Chip
  def initialize(cartridge, bytes)
    super

    # The ROM Bank Number defaults to 01 at power-on.
    @rom_bank = 1
    @ram_bank = 0
    # RAM Disabled by default
    @ram_enabled = false
    # Simple ROM banking mode by default
    @banking_mode = 0
  end

  def read_rom_byte(address)
    return @rom[address] if address < ROM_BANK_SIZE

    @rom[address + ROM_BANK_SIZE * (@rom_bank - 1)]
  end

  def write_rom_byte(address, value)
    if address <= 0x1FFF
      # RAM Enable
      @ram_enabled = value & 0xA == 0xA
    elsif address <= 0x3FFF
      # ROM Bank number
      @rom_bank = value & 0x1F
      # When 00 is written, the MBC translates that to bank 01 also.
      @rom_bank = 1 if @rom_bank == 0
    elsif address <= 0x5FFF
      # RAM Bank Number - or - Upper Bits of ROM Bank Number
      @rom_bank = value & 0x3
    else
      # Banking mode select
      @banking_mode = value & 0x1
    end
  end

  def read_ram_byte(address)
    @ram[address - RAM_OFFSET + (RAM_BANK_SIZE * @ram_bank)]
  end

  def read_ram_memory(address, size)
    @ram[address - RAM_OFFSET + (RAM_BANK_SIZE * @ram_bank), size]
  end

  def write_ram_byte(address, value)
    @ram[address - RAM_OFFSET + (RAM_BANK_SIZE * @ram_bank)] = value
  end
end
