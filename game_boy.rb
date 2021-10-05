require_relative 'game_boy/debugger'
require_relative 'game_boy/bus'
require_relative 'game_boy/cpu'
require_relative 'game_boy/ppu'
require_relative 'game_boy/timer'

require 'benchmark'

class GameBoy
  include BUS
  include Debugger

  CYCLES_PER_FRAME = 70_224.freeze

  attr_reader :cpu, :bus, :ppu, :cartridge, :timer, :io_registers, :hram

  def initialize
    init_bus
    @cpu = CPU.new(self)
    @ppu = PPU.new(self)
    @timer = Timer.new(self)
  end

  def load_cartridge(cartridge)
    @cartridge = cartridge
  end

  def play(boot: true)
    skip_boot unless boot

    cycles = 0

    loop do
      cycles += @cpu.step
      cycles -= CYCLES_PER_FRAME if cycles >= CYCLES_PER_FRAME
      @timer.step(cycles)
      @ppu.step(cycles)
    end
  end
end
