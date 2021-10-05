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

    set_flags(
      (result & 0xFF) == 0,
      0,
      (@a & 0x0f) + (value & 0x0f) + flag_c_bit > 0x0f,
      result > 0xff
    )

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

    set_flags(
      (result & 0xFF) == 0,
      0,
      (@a & 0x0f) + (value & 0x0f) > 0x0f,
      result > 0xFF
    )

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

  def cp(value)
    set_flags(
      @a == value,
      1,
      (@a & 0x0f) < (value & 0x0f),
      @a - value < 0
    )
  end
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

  # def daa; raise NotImplementedError.new('daa instruction not implemented yet'); end

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
      result & 0xFF == 0x0,
      result & 0xF == 0
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

  def rl_a_hl; raise NotImplementedError.new('rl_a_hl instruction not implemented yet'); end
  def rl_a; raise NotImplementedError.new('rl_a instruction not implemented yet'); end
  def rl_b; raise NotImplementedError.new('rl_b instruction not implemented yet'); end
  def rl_c; raise NotImplementedError.new('rl_c instruction not implemented yet'); end
  def rl_d; raise NotImplementedError.new('rl_d instruction not implemented yet'); end
  def rl_e; raise NotImplementedError.new('rl_e instruction not implemented yet'); end
  def rl_h; raise NotImplementedError.new('rl_h instruction not implemented yet'); end
  def rl_l; raise NotImplementedError.new('rl_l instruction not implemented yet'); end

  def rla; raise NotImplementedError.new('rla instruction not implemented yet'); end

  def rlc_a_hl; raise NotImplementedError.new('rlc_a_hl instruction not implemented yet'); end
  def rlc_a; raise NotImplementedError.new('rlc_a instruction not implemented yet'); end
  def rlc_b; raise NotImplementedError.new('rlc_b instruction not implemented yet'); end
  def rlc_c; raise NotImplementedError.new('rlc_c instruction not implemented yet'); end
  def rlc_d; raise NotImplementedError.new('rlc_d instruction not implemented yet'); end
  def rlc_e; raise NotImplementedError.new('rlc_e instruction not implemented yet'); end
  def rlc_h; raise NotImplementedError.new('rlc_h instruction not implemented yet'); end
  def rlc_l; raise NotImplementedError.new('rlc_l instruction not implemented yet'); end

  def rlca; set_flags(0, 0, 0, flag_z_bit); @a = @a.lrot8(1); end

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
  def rr_a_hl; raise NotImplementedError.new('rr_a_hl instruction not implemented yet'); end

  def rra()= rr_a

  def rrc_a_hl; raise NotImplementedError.new('rrc_a_hl instruction not implemented yet'); end
  def rrc_a; raise NotImplementedError.new('rrc_a instruction not implemented yet'); end
  def rrc_b; raise NotImplementedError.new('rrc_b instruction not implemented yet'); end
  def rrc_c; raise NotImplementedError.new('rrc_c instruction not implemented yet'); end
  def rrc_d; raise NotImplementedError.new('rrc_d instruction not implemented yet'); end
  def rrc_e; raise NotImplementedError.new('rrc_e instruction not implemented yet'); end
  def rrc_h; raise NotImplementedError.new('rrc_h instruction not implemented yet'); end
  def rrc_l; raise NotImplementedError.new('rrc_l instruction not implemented yet'); end
  def rrca; raise NotImplementedError.new('rrca instruction not implemented yet'); end

  def sbc(value)
    result = @a - value - flag_c_bit;

    set_flags(
      (result & 0xFF) == 0,
      1,
      (value & 0x0f) + flag_c_bit > (@a & 0x0f),
      result < 0
    )

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
  def sla_a_hl; raise NotImplementedError.new('sla_a_hl instruction not implemented yet'); end

  def sra_a_hl; raise NotImplementedError.new('sra_a_hl instruction not implemented yet'); end
  def sra_a; raise NotImplementedError.new('sra_a instruction not implemented yet'); end
  def sra_b; raise NotImplementedError.new('sra_b instruction not implemented yet'); end
  def sra_c; raise NotImplementedError.new('sra_c instruction not implemented yet'); end
  def sra_d; raise NotImplementedError.new('sra_d instruction not implemented yet'); end
  def sra_e; raise NotImplementedError.new('sra_e instruction not implemented yet'); end
  def sra_h; raise NotImplementedError.new('sra_h instruction not implemented yet'); end
  def sra_l; raise NotImplementedError.new('sra_l instruction not implemented yet'); end

  def srl(value); old = value; [value >> 1 & 0xFF, old & 1]; end
  def srl_a; @a, c = srl(@a); set_flags(@a == 0, 0, 0, c); end
  def srl_b; @b, c = srl(@b); set_flags(@b == 0, 0, 0, c); end
  def srl_c; @c, c = srl(@c); set_flags(@c == 0, 0, 0, c); end
  def srl_d; @d, c = srl(@d); set_flags(@d == 0, 0, 0, c); end
  def srl_e; @e, c = srl(@e); set_flags(@e == 0, 0, 0, c); end
  def srl_h; @h, c = srl(@h); set_flags(@h == 0, 0, 0, c); end
  def srl_l; @l, c = srl(@l); set_flags(@l == 0, 0, 0, c); end
  def srl_a_hl; raise NotImplementedError.new('srl_a_hl instruction not implemented yet'); end

  def stop_0; raise NotImplementedError.new('stop_0 instruction not implemented yet'); end

  def sub(b)
    result = @a - b

    set_flags(
      result == 0,
      1,
      (b & 0x0f) > (@a & 0x0f),
      result < 0
    )

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

  def swap(byte) (byte << 4) | (byte >> 4); end
  def swap_a; @a = swap(@a); set_flags(@a == 0, 0, 0, 0); end
  def swap_b; @b = swap(@b); set_flags(@b == 0, 0, 0, 0); end
  def swap_c; @c = swap(@c); set_flags(@c == 0, 0, 0, 0); end
  def swap_d; @d = swap(@d); set_flags(@d == 0, 0, 0, 0); end
  def swap_e; @e = swap(@e); set_flags(@e == 0, 0, 0, 0); end
  def swap_h; @h = swap(@h); set_flags(@h == 0, 0, 0, 0); end
  def swap_l; @l = swap(@l); set_flags(@l == 0, 0, 0, 0); end
  def swap_a_hl; raise NotImplementedError.new('swap_a_hl instruction not implemented yet'); end
end
