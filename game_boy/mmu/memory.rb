class Memory
  attr_reader :memory

  def initialize(size, offset, device)
    @size = size
    @offset = offset
    @device = device
    @memory = Array.new(@size) { 0x0 }
  end

  def read_byte(address)
    # value = @memory[address - @offset]

    # raise 'Memory cannot read value from address 0x%04X, %s' % [address, value] if value.nil? || !value.is_a?(Integer) || value < 0 || value > 0xFF

    # return value

    @memory[address - @offset]
  end

  def read_word(address)
    return (read_byte(address + 1) << 8) + read_byte(address)
  end

  def write_byte(address, value)
    @memory[address - @offset] = value
  end

  def read_memory(address, size)
    @memory[address - @offset, size]
  end

  def write_memory(address, bytes)
    @memory[address - @offset, bytes.size] = bytes
  end
end
