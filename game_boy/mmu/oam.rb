require_relative 'memory'

class OAM < Memory
  # FE00..FE9F Sprite attribute table (OAM)
  def initialize(device)
    super(0xA0, 0xFE00, device)
  end

  def dma(value)
    source = value << 8
    bytes = @device.read_memory(source, 0x9F)
    write_memory(0xFE00, bytes)
  end
end
