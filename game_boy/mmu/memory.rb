class Memory
  attr_reader :memory

  def initialize(size, offset, device)
    @size = size
    @offset = offset
    @device = device
    @memory = Array.new(@size) { 0x0 }
  end

  def read_byte(address)
    return @memory[address - @offset]
  end

  def read_word(address)
    return (read_byte(address + 1) << 8) + read_byte(address)
  end

  def write_byte(address, value)
    @memory[address - @offset] = value
  end
end
