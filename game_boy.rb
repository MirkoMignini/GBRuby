require_relative 'game_boy/bus'
require_relative 'game_boy/cpu'
require_relative 'game_boy/input'
require_relative 'game_boy/ppu'
require_relative 'game_boy/timer'

require 'sdl2'

class GameBoy
  include BUS

  attr_reader :cpu, :ppu, :cartridge, :timer, :input

  def initialize
    init_bus

    @cpu = CPU.new(self)
    @ppu = PPU.new(self)
    @input = Input.new(self)
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

  def skip_boot
    # set cpu register state
    @cpu.register_set('PC', 0x0100)
    @cpu.register_set('AF', 0x01B0)
    @cpu.register_set('BC', 0x0013)
    @cpu.register_set('DE', 0x00D8)
    @cpu.register_set('HL', 0x014D)
    @cpu.register_set('SP', 0xFFFE)

    # set IO reigster state
    write_byte(0xFF10, 0x80)
    write_byte(0xFF11, 0xBF)
    write_byte(0xFF12, 0xF3)
    write_byte(0xFF14, 0xBF)
    write_byte(0xFF16, 0x3F)
    write_byte(0xFF19, 0xBF)
    write_byte(0xFF1A, 0x7F)
    write_byte(0xFF1B, 0xFF)
    write_byte(0xFF1C, 0x9F)
    write_byte(0xFF1E, 0xBF)
    write_byte(0xFF20, 0xFF)
    write_byte(0xFF23, 0xBF)
    write_byte(0xFF24, 0x77)
    write_byte(0xFF25, 0xF3)
    write_byte(0xFF26, 0xF1)
    write_byte(0xFF40, 0x91)
    write_byte(0xFF41, 0x05)
    write_byte(0xFF47, 0xFC)
    write_byte(0xFF48, 0xFF)
    write_byte(0xFF49, 0xFF)

    # unmap the boot rom
    write_byte(0xFF50, 0x01)
  end
end
