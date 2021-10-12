require_relative 'chip'

class Header
  def initialize(bytes)
    @bytes = bytes[0, 0x150]
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

  def title
    @bytes[0x134..0x143].pack('c*')
  end
end
