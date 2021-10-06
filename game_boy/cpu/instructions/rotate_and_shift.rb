module RotateAndShift
  def rl(value)
    c = value & 0x80 == 0x80
    result = ((value << 1) & 0xFF) + flag_c_bit
    set_flags(result == 0, 0, 0, c)
    result
  end
  def rl_a()= @a = rl(@a)
  def rl_b()= @b = rl(@b)
  def rl_c()= @c = rl(@c)
  def rl_d()= @d = rl(@d)
  def rl_e()= @e = rl(@e)
  def rl_h()= @h = rl(@h)
  def rl_l()= @l = rl(@l)
  def rl_a_hl()= write_byte(hl, rl(read_byte(hl)))

  def rla
    c = @a & 0x80 == 0x80
    @a = ((@a << 1) & 0xFF) + flag_c_bit
    set_flags(0, 0, 0, c)
  end

  def rlca;
    c = @a & 0x80 == 0x80
    @a = @a.lrot8(1)
    set_flags(0, 0, 0, c)
  end
  def rlc(value)
    c = value & 0x80 == 0x80
    result = value.lrot8(1)
    set_flags(result == 0, 0, 0, c)
    result
  end
  def rlc_a()= @a = rlc(@a)
  def rlc_b()= @b = rlc(@b)
  def rlc_c()= @c = rlc(@c)
  def rlc_d()= @d = rlc(@d)
  def rlc_e()= @e = rlc(@e)
  def rlc_h()= @h = rlc(@h)
  def rlc_l()= @l = rlc(@l)
  def rlc_a_hl()= write_byte(hl, rlc(read_byte(hl)))

  def rr(value)
    [
      (value >> 1) | (flag_c_bit << 7),
      value & 0x01 == 0x01
    ]
  end
  def rr_a; @a, c = rr(@a); set_flags(@a == 0, 0, 0, c); end
  def rr_b; @b, c = rr(@b); set_flags(@b == 0, 0, 0, c); end
  def rr_c; @c, c = rr(@c); set_flags(@c == 0, 0, 0, c); end
  def rr_d; @d, c = rr(@d); set_flags(@d == 0, 0, 0, c); end
  def rr_e; @e, c = rr(@e); set_flags(@e == 0, 0, 0, c); end
  def rr_h; @h, c = rr(@h); set_flags(@h == 0, 0, 0, c); end
  def rr_l; @l, c = rr(@l); set_flags(@l == 0, 0, 0, c); end
  def rr_a_hl;
    result, c = rr(read_byte(hl))
    set_flags(result == 0, 0, 0, c)
    write_byte(hl, result)
  end

  def rra
    c = @a & 1 == 1
    @a = ((@a >> 1) + (flag_c_bit << 7)) & 0xFF
    set_flags(0, 0, 0, c)
  end

  def rrc(value)
    c = value & 1
    result = value.rrot8(1)
    set_flags(result == 0, 0, 0, c)
    result
  end
  def rrc_a()= @a = rrc(@a)
  def rrc_b()= @b = rrc(@b)
  def rrc_c()= @c = rrc(@c)
  def rrc_d()= @d = rrc(@d)
  def rrc_e()= @e = rrc(@e)
  def rrc_h()= @h = rrc(@h)
  def rrc_l()= @l = rrc(@l)
  def rrc_a_hl()= write_byte(hl, rrc(read_byte(hl)))

  def rrca;
    c = @a & 1 == 1
    @a = @a.rrot8(1)
    set_flags(0, 0, 0, c)
  end

  def sbc(value)
    result = @a - value - flag_c_bit;
    set_flags((result & 0xFF) == 0, 1, (value & 0x0f) + flag_c_bit > (@a & 0x0f), result < 0)
    @a = result & 0xFF
  end
  def sbc_a_a()= sbc(@a)
  def sbc_a_b()= sbc(@b)
  def sbc_a_c()= sbc(@c)
  def sbc_a_d()= sbc(@d)
  def sbc_a_e()= sbc(@e)
  def sbc_a_h()= sbc(@h)
  def sbc_a_l()= sbc(@l)
  def sbc_a_d8()= sbc(pc_read_byte)
  def sbc_a_a_hl()= sbc(read_byte(hl))

  def sla(value); old = value; [value << 1 & 0xFF, old >> 7]; end
  def sla_a; @a, c = sla(@a); set_flags(@a == 0, 0, 0, c); end
  def sla_b; @b, c = sla(@b); set_flags(@b == 0, 0, 0, c); end
  def sla_c; @c, c = sla(@c); set_flags(@c == 0, 0, 0, c); end
  def sla_d; @d, c = sla(@d); set_flags(@d == 0, 0, 0, c); end
  def sla_e; @e, c = sla(@e); set_flags(@e == 0, 0, 0, c); end
  def sla_h; @h, c = sla(@h); set_flags(@h == 0, 0, 0, c); end
  def sla_l; @l, c = sla(@l); set_flags(@l == 0, 0, 0, c); end
  def sla_a_hl
    result, c = sla(read_byte(hl))
    set_flags(result == 0, 0, 0, c)
    write_byte(hl, result)
  end

  def sra(value)
    result = (value >> 1) | value & 0x80
    set_flags(result == 0, 0, 0, value & 1 == 1)
    result
  end
  def sra_a()= @a = sra(@a)
  def sra_b()= @b = sra(@b)
  def sra_c()= @c = sra(@c)
  def sra_d()= @d = sra(@d)
  def sra_e()= @e = sra(@e)
  def sra_h()= @h = sra(@h)
  def sra_l()= @l = sra(@l)
  def sra_a_hl()= write_byte(hl, sra(read_byte(hl)))

  def srl(value); old = value; [value >> 1 & 0xFF, old & 1]; end
  def srl_a; @a, c = srl(@a); set_flags(@a == 0, 0, 0, c); end
  def srl_b; @b, c = srl(@b); set_flags(@b == 0, 0, 0, c); end
  def srl_c; @c, c = srl(@c); set_flags(@c == 0, 0, 0, c); end
  def srl_d; @d, c = srl(@d); set_flags(@d == 0, 0, 0, c); end
  def srl_e; @e, c = srl(@e); set_flags(@e == 0, 0, 0, c); end
  def srl_h; @h, c = srl(@h); set_flags(@h == 0, 0, 0, c); end
  def srl_l; @l, c = srl(@l); set_flags(@l == 0, 0, 0, c); end
  def srl_a_hl
    result, c = srl(read_byte(hl))
    set_flags(result == 0, 0, 0, c)
    write_byte(hl, result)
  end
end
