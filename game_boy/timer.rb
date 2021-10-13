class Timer
  DIV = 0xFF04.freeze
  TIMA = 0xFF05.freeze
  TMA = 0xFF06.freeze

  FREQ_4_KHZ = 4_096.freeze
  FREQ_16_KHZ = 16_384.freeze
  FREQ_64_KHZ = 65_536.freeze
  FREQ_256_KHZ = 262_144.freeze

  def initialize(device)
    @device = device
    @enabled = false
    @div_counter = 0
    @frequency = 0
    reset_tima
  end

  def setup(tac_value)
    @enabled = (tac_value & 0x4 == 0x4)
    @frequency = tac_value & 0x3
    reset_tima
  end

  def reset_tima
    case @frequency
    when 0 then @tima_counter = CPU::CLOCKSPEED / FREQ_4_KHZ
    when 1 then @tima_counter = CPU::CLOCKSPEED / FREQ_256_KHZ
    when 2 then @tima_counter = CPU::CLOCKSPEED / FREQ_64_KHZ
    when 3 then @tima_counter = CPU::CLOCKSPEED / FREQ_16_KHZ
    end
  end

  def step(cycles)
    update_div(cycles)
    update_tima(cycles)
  end

  def update_div(cycles)
    @div_counter += cycles
    return if @div_counter < 0xFF

    @div_counter = 0
    @device.io_registers.inc(IORegisters::DIV)
  end

  def update_tima(cycles)
    return unless @enabled

    @tima_counter -= cycles

    return if @tima_counter > 0

    reset_tima

    if (@device.read_byte(TIMA) == 0xFF)
      @device.io_registers.tima = @device.io_registers.tma
      @device.cpu.request_interrupt(CPU::INTERRUPT_TIMER)
    else
      @device.io_registers.inc(IORegisters::TIMA)
    end
  end
end
