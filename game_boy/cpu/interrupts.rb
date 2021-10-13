module Interrupts
  IF_ADDRESS = 0xFF0F
  IE_ADDRESS = 0xFFFF

  INTERRUPT_VBLANK  = 0b00000001
  INTERRUPT_LCDSTAT = 0b00000010
  INTERRUPT_TIMER   = 0b00000100
  INTERRUPT_SERIAL  = 0b00001000
  INTERRUPT_JOYPAD  = 0b00010000

  INTERRUPT_VBLANK_ADDRESS  = 0x40
  INTERRUPT_LCDSTAT_ADDRESS = 0x48
  INTERRUPT_TIMER_ADDRESS   = 0x50
  INTERRUPT_SERIAL_ADDRESS  = 0x58
  INTERRUPT_JOYPAD_ADDRESS  = 0x50

  def setup_interrupts
    enable_inturrupts
  end

  def disable_inturrupts
    @ime = false
  end

  def enable_inturrupts
    @ime = true
  end

  def request_interrupt(interrupt)
    device.io_registers.if = @if | interrupt
  end

  def reset_interrupt(interrupt)
    device.io_registers.if = @if & (0xFF & ~interrupt)
  end

  def process_interrupts
    requested_interrupts = @if

    return if requested_interrupts == 0x0

    enabled_interrupts = device.hram.read_byte(IE_ADDRESS)
    executable_interrupts = requested_interrupts & enabled_interrupts

    return if executable_interrupts == 0x0

    if (executable_interrupts & INTERRUPT_VBLANK == INTERRUPT_VBLANK)
      @halted = false
      execute_interrupt(INTERRUPT_VBLANK) if @ime
    end

    if (executable_interrupts & INTERRUPT_LCDSTAT == INTERRUPT_LCDSTAT)
      @halted = false
      execute_interrupt(INTERRUPT_LCDSTAT) if @ime
    end

    if (executable_interrupts & INTERRUPT_TIMER == INTERRUPT_TIMER)
      @halted = false
      execute_interrupt(INTERRUPT_TIMER) if @ime
    end

    if (executable_interrupts & INTERRUPT_SERIAL == INTERRUPT_SERIAL)
      @halted = false
      execute_interrupt(INTERRUPT_VBLANK) if @ime
    end

    if (executable_interrupts & INTERRUPT_VBLANK == INTERRUPT_VBLANK)
      @halted = false
      execute_interrupt(INTERRUPT_VBLANK) if @ime
    end
  end

  def execute_interrupt(interrupt)
    disable_inturrupts
    reset_interrupt(interrupt)
    push(@pc)

    case interrupt
    when INTERRUPT_VBLANK   then @pc = INTERRUPT_VBLANK_ADDRESS
    when INTERRUPT_LCDSTAT  then @pc = INTERRUPT_LCDSTAT_ADDRESS
    when INTERRUPT_TIMER    then @pc = INTERRUPT_TIMER_ADDRESS
    when INTERRUPT_SERIAL   then @pc = INTERRUPT_SERIAL_ADDRESS
    when INTERRUPT_JOYPAD   then @pc = INTERRUPT_JOYPAD_ADDRESS
    end
  end
end
