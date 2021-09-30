require_relative 'memory'

class IORegisters < Memory
  # FF00..FF7F  I/O Registers

  SC  = 0xFF02.freeze
  DIV = 0xFF04.freeze
  TAC = 0xFF07.freeze
  DMA = 0xFF46.freeze

  def initialize(device)
    super(0x80, 0xFF00, device)
  end

  def write_byte(address, value)
    if (address == SC && value == 0x81)
      print @memory[1].chr
      @memory[address - @offset] = value
    # writing any value to DIV sets it to $00
    elsif (address == DIV)
      @memory[address - @offset] = 0
    elsif (address == TAC)
      @device.timer.setup(value)
      @memory[address - @offset] = value
    elsif (address == DMA)
      puts 'Performing DMA'
      source = read_byte(address) << 8
      0x9F.times do |index|
        @device.write_byte(0xFE00 + index, @device.read_byte(address + index))
      end
    else
      @memory[address - @offset] = value
    end
  end
end
