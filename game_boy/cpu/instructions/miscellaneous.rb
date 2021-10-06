module Miscellaneous
  def ccf; set_flags(nil, 0, 0, !flag_c?); end

  def cpl; @a ^= 0xFF; set_flags(nil, 1, 1, nil); end

  def daa
    value = @a
    c = nil

    if !flag_n?
      if flag_h? || (value & 0xF) > 0x9
        value = value + 0x06
        c = 1
      end

      if flag_c? || (value > 0x9F)
        value = value + 0x60
      end
    else
      if flag_h?
        value = (value - 0x06) & 0xFF
      end

      if flag_c?
        value = value - 0x60
      end
    end

    set_flags(value & 0xFF == 0 ? 1 : nil, nil, 0, c)

    @a = value & 0xFF
  end

  def di; disable_inturrupts; end
  def ei; enable_inturrupts; end

  def nop; end

  def prefix; fetch_cb; execute; end

  def scf()= set_flags(nil, 0, 0, 1)

  def swap(byte)
    result = (byte << 4 & 0xFF) | (byte >> 4)
    set_flags(result == 0, 0, 0, 0)
    result
  end
  def swap_a()= @a = swap(@a)
  def swap_b()= @b = swap(@b)
  def swap_c()= @c = swap(@c)
  def swap_d()= @d = swap(@d)
  def swap_e()= @e = swap(@e)
  def swap_h()= @h = swap(@h)
  def swap_l()= @l = swap(@l)
  def swap_a_hl
    write_byte(hl, swap(read_byte(hl)))
  end
end
