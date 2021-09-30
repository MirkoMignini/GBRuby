require_relative 'cpu/instructions'
require_relative 'cpu/registers'
require_relative 'cpu/opcodes'
require_relative 'cpu/utils'
require_relative 'cpu/interrupts'

require 'json'
require 'byebug'

class CPU
  include Instructions
  include Registers
  include Utils
  include Interrupts

  CLOCKSPEED = 4_194_304.freeze

  attr_reader :device

  def initialize(device)
    @device = device

    setup_registers
    setup_interrupts

    @halted = false
  end

  def pc_read_byte
    result = device.read_byte(@pc)
    @pc += 1
    result
  end

  def pc_read_signed_byte
    signed_byte(pc_read_byte)
  end

  def pc_read_word
    result = device.read_word(@pc)
    @pc += 2
    result
  end

  def write_byte(address, byte)
    device.write_byte(address, byte)
  end

  def write_word(address, word)
    device.write_byte(address, ( word & 0xFF ))
    device.write_byte(address + 1, ( word >> 8 ))
  end

  def read_byte(address)
    device.read_byte(address)
  end

  def read_word(address)
    device.read_word(address)
  end

  def debug_instruction(pc, instruction)
    "%04X %02X %02X %02X %10s AF:%04X BC:%04X DE:%04X HL:%04X SP:%04X Z:%s N:%s H:%s C:%s" % [
      pc, read_byte(pc), read_byte(pc + 1), read_byte(pc + 2), instruction[:method],
      af, bc, de, hl, @sp, flag_z_bit, flag_h_bit, flag_h_bit, flag_c_bit
    ]
  end

  def step
    process_interrupts

    return 4 if @halted

    @jump = false
    @initial_pc = @pc

    begin
      fetch
      execute
    rescue StandardError => e
      puts "%04X %s" % [@initial_pc, @instruction]
      puts e.backtrace
      puts e
      exit
    end

    @jump ? @instruction[:cycles].first : @instruction[:cycles].last
  end

  def fetch
    @instruction = OPCODES[pc_read_byte]
  end

  def fetch_cb
    @instruction = CB_OPCODES[pc_read_byte]
  end

  def execute
    public_send(@instruction[:method])
  end
end
