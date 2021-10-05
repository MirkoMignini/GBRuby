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

  def adc_byte(a, b); [(a + b + flag_c_bit) & 0xFF, ((a & 0xF) + (b & 0xF) + flag_c_bit) > 0xF, (a + b + flag_c_bit) > 0xFF]; end
  def adc_a_a; @a, h, c = adc_byte(@a, @a); set_flags(@a == 0, 0, h, c); end
  def adc_a_b; @a, h, c = adc_byte(@a, @b); set_flags(@a == 0, 0, h, c); end
  def adc_a_c; @a, h, c = adc_byte(@a, @c); set_flags(@a == 0, 0, h, c); end
  def adc_a_d; @a, h, c = adc_byte(@a, @d); set_flags(@a == 0, 0, h, c); end
  def adc_a_e; @a, h, c = adc_byte(@a, @e); set_flags(@a == 0, 0, h, c); end
  def adc_a_h; @a, h, c = adc_byte(@a, @h); set_flags(@a == 0, 0, h, c); end
  def adc_a_l; @a, h, c = adc_byte(@a, @l); set_flags(@a == 0, 0, h, c); end
  def adc_a_d8; @a, h, c = adc_byte(@a, pc_read_byte); set_flags(@a == 0, 0, h, c); end
  def adc_a_a_hl; raise NotImplementedError.new('adc_a_a_hl instruction not implemented yet'); end

  def add_byte(a, b)
    result = a + b

    [
      result & 0xFF,
      result & 0xFF == 0x0,
      0,
      (a ^ b ^ result) & 0x100 == 0x100,
      (a ^ b ^ result) & 0x10 == 0x10
    ]
  end
  def add_a_a; @a, z, n, h, c = add_byte(@a, @a); set_flags(z, n, h, c); end
  def add_a_b; @a, z, n, h, c = add_byte(@a, @b); set_flags(z, n, h, c); end
  def add_a_c; @a, z, n, h, c = add_byte(@a, @c); set_flags(z, n, h, c); end
  def add_a_d; @a, z, n, h, c = add_byte(@a, @d); set_flags(z, n, h, c); end
  def add_a_e; @a, z, n, h, c = add_byte(@a, @e); set_flags(z, n, h, c); end
  def add_a_h; @a, z, n, h, c = add_byte(@a, @h); set_flags(z, n, h, c); end
  def add_a_l; @a, z, n, h, c = add_byte(@a, @l); set_flags(z, n, h, c); end
  def add_a_d8; @a, z, n, h, c = add_byte(@a, pc_read_byte); set_flags(z, n, h, c); end
  def add_a_a_hl; @a, z, n, h, c = add_byte(@a, read_byte(hl)); set_flags(z, n, h, c); end

  def add_word(a, b); [a + b & 0xFFFF, (a & 0xFFF) + (b & 0xFFF) > 0xFFF, a + b > 0xFFFF]; end
  def add_hl_bc; self.hl, h, c = add_word(hl, bc); set_flags(nil, 0, h, c); end
  def add_hl_de; self.hl, h, c = add_word(hl, de); set_flags(nil, 0, h, c); end
  def add_hl_hl; self.hl, h, c = add_word(hl, hl); set_flags(nil, 0, h, c); end
  def add_hl_sp; self.hl, h, c = add_word(hl, @sp); set_flags(nil, 0, h, c); end

  def add_sp_r8; @sp, h, c = add_word(@sp, pc_read_signed_byte); set_flags(0, 0, h, c); end

  def ccf; set_flags(nil, 0, 0, !flag_c?); end

  def cp(a, b); [a - b && 0xFF, 1, (a & 0xF) - (b & 0xF) < 0, a - b < 0]; end
  # def cp(a, b)
  #   result = a - b

  #   [
  #     a == b,
  #     1,
  #     (result & 0xF) > (a & 0xF),
  #     a < b
  #   ]
  #   # [
  #   #   a == b,
	# 	#   1,
	# 	#   (a & 0xF) - (b & 0xF) < 0,
	# 	#   a - b < 0
  #   # ]
  # end

  # result = @a - @b
  # result & 0xFF == 0x0 ? set_z_flag : reset_z_flag
  # @a < @b ? set_c_flag : reset_c_flag
  # (result & 0xF) > (@a & 0xF) ? set_h_flag : reset_h_flag
  # set_n_flag

  def cp_a; set_flags(*cp(@a, @a)); end
  def cp_b; set_flags(*cp(@a, @b)); end
  def cp_c; set_flags(*cp(@a, @c)); end
  def cp_d; set_flags(*cp(@a, @d)); end
  def cp_e; set_flags(*cp(@a, @e)); end
  def cp_h; set_flags(*cp(@a, @h)); end
  def cp_l; set_flags(*cp(@a, @l)); end
  def cp_d8; set_flags(*cp(@a, pc_read_byte)); end
  def cp_a_hl; set_flags(*cp(@a, read_byte(hl))); end

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
      result & 0xF == 0xF
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
      result & 0xFF == 0x0,
      result & 0xF == 0x0
    ]
  end
  def inc_a; @a, z, hc = byte_inc(@a); set_flags(z, 1, hc, nil); end
  def inc_b; @b, z, hc = byte_inc(@b); set_flags(z, 1, hc, nil); end
  def inc_c; @c, z, hc = byte_inc(@c); set_flags(z, 1, hc, nil); end
  def inc_d; @d, z, hc = byte_inc(@d); set_flags(z, 1, hc, nil); end
  def inc_e; @e, z, hc = byte_inc(@e); set_flags(z, 1, hc, nil); end
  def inc_h; @h, z, hc = byte_inc(@h); set_flags(z, 1, hc, nil); end
  def inc_l; @l, z, hc = byte_inc(@l); set_flags(z, 1, hc, nil); end
  def inc_bc; self.bc = bc + 1 & 0xFFFF; end
  def inc_de; self.de = de + 1 & 0xFFFF; end
  def inc_hl; self.hl = hl + 1 & 0xFFFF; end
  def inc_sp; @sp = @sp + 1 & 0xFFFF; end
  def inc_a_hl
    res, z, hc = byte_inc(read_byte(hl))
    set_flags(z, 1, hc, nil)
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

  def rr(value); [value.rrot8(1), value & 1]; end
  def rr_a; @a, c = rr(@a); set_flags(@a == 0, 0, 0, c); end
  def rr_b; @b, c = rr(@b); set_flags(@b == 0, 0, 0, c); end
  def rr_c; @c, c = rr(@c); set_flags(@c == 0, 0, 0, c); end
  def rr_d; @d, c = rr(@d); set_flags(@d == 0, 0, 0, c); end
  def rr_e; @e, c = rr(@e); set_flags(@e == 0, 0, 0, c); end
  def rr_h; @h, c = rr(@h); set_flags(@h == 0, 0, 0, c); end
  def rr_l; @l, c = rr(@l); set_flags(@l == 0, 0, 0, c); end
  def rr_a_hl; raise NotImplementedError.new('rr_a_hl instruction not implemented yet'); end

  def rra; c = @a & 0x01 == 0x01; @a = @a.rrot8(1) | (flag_c_bit << 7); set_flags(@a == 0, 0, 0, c); end
  def rrc_a_hl; raise NotImplementedError.new('rrc_a_hl instruction not implemented yet'); end
  def rrc_a; raise NotImplementedError.new('rrc_a instruction not implemented yet'); end
  def rrc_b; raise NotImplementedError.new('rrc_b instruction not implemented yet'); end
  def rrc_c; raise NotImplementedError.new('rrc_c instruction not implemented yet'); end
  def rrc_d; raise NotImplementedError.new('rrc_d instruction not implemented yet'); end
  def rrc_e; raise NotImplementedError.new('rrc_e instruction not implemented yet'); end
  def rrc_h; raise NotImplementedError.new('rrc_h instruction not implemented yet'); end
  def rrc_l; raise NotImplementedError.new('rrc_l instruction not implemented yet'); end
  def rrca; raise NotImplementedError.new('rrca instruction not implemented yet'); end

  def sbc_a_a_hl; raise NotImplementedError.new('sbc_a_a_hl instruction not implemented yet'); end
  def sbc_a_a; raise NotImplementedError.new('sbc_a_a instruction not implemented yet'); end
  def sbc_a_b; raise NotImplementedError.new('sbc_a_b instruction not implemented yet'); end
  def sbc_a_c; raise NotImplementedError.new('sbc_a_c instruction not implemented yet'); end
  def sbc_a_d; raise NotImplementedError.new('sbc_a_d instruction not implemented yet'); end
  def sbc_a_d8; raise NotImplementedError.new('sbc_a_d8 instruction not implemented yet'); end
  def sbc_a_e; raise NotImplementedError.new('sbc_a_e instruction not implemented yet'); end
  def sbc_a_h; raise NotImplementedError.new('sbc_a_h instruction not implemented yet'); end
  def sbc_a_l; raise NotImplementedError.new('sbc_a_l instruction not implemented yet'); end

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

  def sub_byte(a, b)
    result = a - b

    [
      result & 0xFF,
      result & 0xFF == 0x0,
      1,
      (a ^ b ^ result) & 0x100 == 0x100,
      (a ^ b ^ result) & 0x10 == 0x10
    ]
  end
  def sub_a; @a, z, n, h, c = sub_byte(@a, @a); set_flags(z, n, h, c); end
  def sub_b; @a, z, n, h, c = sub_byte(@a, @b); set_flags(z, n, h, c); end
  def sub_c; @a, z, n, h, c = sub_byte(@a, @c); set_flags(z, n, h, c); end
  def sub_d; @a, z, n, h, c = sub_byte(@a, @d); set_flags(z, n, h, c); end
  def sub_e; @a, z, n, h, c = sub_byte(@a, @e); set_flags(z, n, h, c); end
  def sub_h; @a, z, n, h, c = sub_byte(@a, @h); set_flags(z, n, h, c); end
  def sub_l; @a, z, n, h, c = sub_byte(@a, @l); set_flags(z, n, h, c); end
  def sub_d8; @a, z, n, h, c = sub_byte(@a, pc_read_byte); set_flags(z, n, h, c); end
  def sub_a_hl; @a, z, n, h, c = sub_byte(@a, read_byte(hl)); set_flags(z, n, h, c); end

  def swap(byte) ((byte & 0x0F) << 4) + ((byte & 0xF0) >> 4); end
  def swap_a; @a = swap(@a); set_flags(@a == 0, 0, 0, 0); end
  def swap_b; @b = swap(@b); set_flags(@b == 0, 0, 0, 0); end
  def swap_c; @c = swap(@c); set_flags(@c == 0, 0, 0, 0); end
  def swap_d; @d = swap(@d); set_flags(@d == 0, 0, 0, 0); end
  def swap_e; @e = swap(@e); set_flags(@e == 0, 0, 0, 0); end
  def swap_h; @h = swap(@h); set_flags(@h == 0, 0, 0, 0); end
  def swap_l; @l = swap(@l); set_flags(@l == 0, 0, 0, 0); end
  def swap_a_hl; raise NotImplementedError.new('swap_a_hl instruction not implemented yet'); end
end
