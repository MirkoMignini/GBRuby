require_relative 'memory'

class HRAM < Memory
  # FF80..FFFE	High RAM (HRAM)

  def initialize(device)
    super(0x80, 0xFF80, device)
  end
end
