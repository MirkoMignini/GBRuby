module Miscellaneous
  def ccf; set_flags(nil, 0, 0, !flag_c?); end

  def cpl; @a ^= 0xFF; set_flags(nil, 1, 1, nil); end

  def daa
    value = @a

    if flag_n?
      value = (value - 0x06) & 0xFF if flag_h?
      value -= 0x60 if flag_c?
    else
      value += 0x06 if flag_h? || (value & 0xF) > 0x9
      value += 0x60 if flag_c? || (value > 0x9F)
    end

    c = 1 if value & 0x100 == 0x100
    @a = value & 0xFF
    set_flags(@a == 0, nil, 0, c)
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
