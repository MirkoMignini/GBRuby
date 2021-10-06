require 'byebug'
require 'bit-twiddle/core_ext'

require_relative 'instructions/bits'
require_relative 'instructions/flow'
require_relative 'instructions/load'
require_relative 'instructions/logic'

module Instructions
  include Bits
  include Flow
  include Load
  include Logic

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

  def ccf; set_flags(nil, 0, 0, !flag_c?); end

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

  def di; disable_inturrupts; end
  def ei; enable_inturrupts; end

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

  def nop; end

  def prefix; fetch_cb; execute; end

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

  def scf()= set_flags(nil, 0, 0, 1)

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

  def stop_0; raise NotImplementedError.new('stop_0 instruction not implemented yet'); end

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
