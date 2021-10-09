require_relative 'game_boy/debugger'
require_relative 'game_boy/bus'
require_relative 'game_boy/cpu'
require_relative 'game_boy/ppu'
require_relative 'game_boy/timer'
require 'sdl2'

class GameBoy
  include BUS
  include Debugger

  CYCLES_PER_FRAME = 70_224.freeze

  attr_reader :cpu, :bus, :ppu, :cartridge, :timer, :io_registers, :hram, :vram, :oam

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

    loop do
      cycles = @cpu.step
      @timer.step(cycles)
      @ppu.step(cycles)
    end

  rescue StandardError => e
    puts e.backtrace
    puts e
    exit
  end
end
