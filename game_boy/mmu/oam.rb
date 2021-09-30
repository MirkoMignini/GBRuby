require_relative 'memory'

class OAM < Memory
  # FE00..FE9F Sprite attribute table (OAM)
  def initialize(device)
    super(0xA0, 0xFE00, device)
  end
end
