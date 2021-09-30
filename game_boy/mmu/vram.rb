require_relative 'memory'

class VRAM < Memory
  # 8KB Video RAM (VRAM)	Only bank 0 in Non-CGB mode / Switchable bank 0/1 in CGB mode

  def initialize(device)
    super(8192, 0x8000, device)
  end
end
