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
    write_byte(IF_ADDRESS, read_byte(IF_ADDRESS) | interrupt)
  end

  def reset_interrupt(interrupt)
    write_byte(IF_ADDRESS, read_byte(IF_ADDRESS) & (0xFF & ~interrupt))
  end

  def process_interrupts
    requested_interrupts = read_byte(IF_ADDRESS)

    return if requested_interrupts == 0x0

    enabled_interrupts = read_byte(IE_ADDRESS)

    [ INTERRUPT_VBLANK,
      INTERRUPT_LCDSTAT,
      INTERRUPT_TIMER,
      INTERRUPT_SERIAL,
      INTERRUPT_JOYPAD ].each do |interrupt|
      if (requested_interrupts & interrupt == interrupt) && (enabled_interrupts & interrupt == interrupt)
        @halted = false
        execute_interrupt(interrupt) if @ime
      end
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
