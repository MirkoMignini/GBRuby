class Input
  KEY_MAPPING = {
    0x20        => :start,   # space
    0x0d        => :select,  # return
    0x7a        => :a,       # `Z'
    0x78        => :b,       # `X'
    0x4000_004f => :right,
    0x4000_0050 => :left,
    0x4000_0051 => :down,
    0x4000_0052 => :up
  }.freeze

  BUTTONS = 0x10.freeze
  KEYPAD = 0x20.freeze

  def initialize(device)
    @device = device
    @event = FFI::MemoryPointer.new(:uint32, 16)
    @keyboard_sym_offset = SDL2::KeyboardEvent.offset_of(:sym)
    @keypad_status = 0xF
    @buttons_status = 0xF
  end

  def dispose
  end

  def step
    while SDL2.PollEvent(@event) != 0
      case @event.read_int
      when SDL2::EVENT_QUIT
        exit
      when SDL2::EVENT_KEYDOWN
        key = KEY_MAPPING[@event.get_int(@keyboard_sym_offset)]
        keydown(key) if key
      when SDL2::EVENT_KEYUP
        key = KEY_MAPPING[@event.get_int(@keyboard_sym_offset)]
        keyup(key) if key
      end
    end
  end

  def read_keyboard(value)
    if (value & BUTTONS == BUTTONS)
      BUTTONS + @buttons_status
    elsif (value & KEYPAD == KEYPAD)
      KEYPAD + @keypad_status
    else
      0xFF
    end
  end

  def keydown(key)
    case key
    when :start   then @buttons_status  &= 0b0111
    when :select  then @buttons_status  &= 0b1011
    when :b       then @buttons_status  &= 0b1101
    when :a       then @buttons_status  &= 0b1110
    when :down    then @keypad_status   &= 0b0111
    when :up      then @keypad_status   &= 0b1011
    when :left    then @keypad_status   &= 0b1101
    when :right   then @keypad_status   &= 0b1110
    end
  end

  def keyup(key)
    case key
    when :start   then @buttons_status  |= 8
    when :select  then @buttons_status  |= 4
    when :b       then @buttons_status  |= 2
    when :a       then @buttons_status  |= 1
    when :down    then @keypad_status   |= 8
    when :up      then @keypad_status   |= 4
    when :left    then @keypad_status   |= 2
    when :right   then @keypad_status   |= 1
    end
  end
end
