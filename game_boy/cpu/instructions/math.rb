module Math
  def adc_a(value)
    result = @a + value + flag_c_bit;
    set_flags((result & 0xFF) == 0, 0, (@a & 0x0f) + (value & 0x0f) + flag_c_bit > 0x0f, result > 0xff)
    @a = result & 0xFF
  end
  def adc_a_a()= adc_a(@a)
  def adc_a_b()= adc_a(@b)
  def adc_a_c()= adc_a(@c)
  def adc_a_d()= adc_a(@d)
  def adc_a_e()= adc_a(@e)
  def adc_a_h()= adc_a(@h)
  def adc_a_l()= adc_a(@l)
  def adc_a_d8()= adc_a(pc_read_byte)
  def adc_a_a_hl()= adc_a(read_byte(hl))

  def add_a(value)
    result = @a + value
    set_flags((result & 0xFF) == 0, 0, (@a & 0x0f) + (value & 0x0f) > 0x0f, result > 0xFF)
    @a = result & 0xFF
  end
  def add_a_a()= add_a(@a)
  def add_a_b()= add_a(@b)
  def add_a_c()= add_a(@c)
  def add_a_d()= add_a(@d)
  def add_a_e()= add_a(@e)
  def add_a_h()= add_a(@h)
  def add_a_l()= add_a(@l)
  def add_a_d8()= add_a(pc_read_byte)
  def add_a_a_hl()= add_a(read_byte(hl))

  def add_word(a, b); [a + b & 0xFFFF, (a & 0xFFF) + (b & 0xFFF) > 0xFFF, a + b > 0xFFFF]; end
  def add_hl_bc; self.hl, h, c = add_word(hl, bc); set_flags(nil, 0, h, c); end
  def add_hl_de; self.hl, h, c = add_word(hl, de); set_flags(nil, 0, h, c); end
  def add_hl_hl; self.hl, h, c = add_word(hl, hl); set_flags(nil, 0, h, c); end
  def add_hl_sp; self.hl, h, c = add_word(hl, @sp); set_flags(nil, 0, h, c); end

  def add_sp_r8; @sp, h, c = add_word(@sp, pc_read_signed_byte); set_flags(nil, 0, h, c); end

  def cp(value)= set_flags(@a == value, 1, (@a & 0x0f) < (value & 0x0f), @a - value < 0)
  def cp_a()= cp(@a)
  def cp_b()= cp(@b)
  def cp_c()= cp(@c)
  def cp_d()= cp(@d)
  def cp_e()= cp(@e)
  def cp_h()= cp(@h)
  def cp_l()= cp(@l)
  def cp_d8()= cp(pc_read_byte)
  def cp_a_hl()= cp(read_byte(hl))

  def byte_dec(value)
    result = value - 1
    [
      result & 0xFF,
      result & 0xFF == 0,
      value & 0xF == 0
    ]
  end
  def dec_a; @a, z, hc = byte_dec(@a); set_flags(z, 1, hc, nil); end
  def dec_b; @b, z, hc = byte_dec(@b); set_flags(z, 1, hc, nil); end
  def dec_c; @c, z, hc = byte_dec(@c); set_flags(z, 1, hc, nil); end
  def dec_d; @d, z, hc = byte_dec(@d); set_flags(z, 1, hc, nil); end
  def dec_e; @e, z, hc = byte_dec(@e); set_flags(z, 1, hc, nil); end
  def dec_h; @h, z, hc = byte_dec(@h); set_flags(z, 1, hc, nil); end
  def dec_l; @l, z, hc = byte_dec(@l); set_flags(z, 1, hc, nil); end
  def dec_bc; self.bc = bc - 1 & 0xFFFF; end
  def dec_de; self.de = de - 1 & 0xFFFF; end
  def dec_hl; self.hl = hl - 1 & 0xFFFF; end
  def dec_sp; @sp = @sp - 1 & 0xFFFF; end
  def dec_a_hl
    res, z, hc = byte_dec(read_byte(hl))
    set_flags(z, 1, hc, nil)
    write_byte(hl, res);
  end

  def byte_inc(value)
    result = value + 1
    [
      result & 0xFF,
      result & 0xFF == 0,
      result & 0xF == 0
    ]
  end
  def inc_a; @a, z, hc = byte_inc(@a); set_flags(z, 0, hc, nil); end
  def inc_b; @b, z, hc = byte_inc(@b); set_flags(z, 0, hc, nil); end
  def inc_c; @c, z, hc = byte_inc(@c); set_flags(z, 0, hc, nil); end
  def inc_d; @d, z, hc = byte_inc(@d); set_flags(z, 0, hc, nil); end
  def inc_e; @e, z, hc = byte_inc(@e); set_flags(z, 0, hc, nil); end
  def inc_h; @h, z, hc = byte_inc(@h); set_flags(z, 0, hc, nil); end
  def inc_l; @l, z, hc = byte_inc(@l); set_flags(z, 0, hc, nil); end
  def inc_bc; self.bc = bc + 1 & 0xFFFF; end
  def inc_de; self.de = de + 1 & 0xFFFF; end
  def inc_hl; self.hl = hl + 1 & 0xFFFF; end
  def inc_sp; @sp = @sp + 1 & 0xFFFF; end
  def inc_a_hl
    res, z, hc = byte_inc(read_byte(hl))
    set_flags(z, 0, hc, nil)
    write_byte(hl, res);
  end

  def sub(b)
    result = @a - b
    set_flags(result == 0, 1, (b & 0x0f) > (@a & 0x0f), result < 0)
    @a = result & 0xFF
  end
  def sub_a()= sub(@a)
  def sub_b()= sub(@b)
  def sub_c()= sub(@c)
  def sub_d()= sub(@d)
  def sub_e()= sub(@e)
  def sub_h()= sub(@h)
  def sub_l()= sub(@l)
  def sub_d8()= sub(pc_read_byte)
  def sub_a_hl()= sub(read_byte(hl))
end
