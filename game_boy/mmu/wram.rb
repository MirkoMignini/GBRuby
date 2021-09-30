require_relative 'memory'

class WRAM < Memory
  # C000..CFFF	4KB Work RAM (WRAM) bank 0
  # D000..DFFF	4KB Work RAM (WRAM) bank 1~N	Only bank 1 in Non-CGB mode / Switchable bank 1~7 in CGB mode

  def initialize(device)
    super(8192, 0xC000, device)
  end
end
