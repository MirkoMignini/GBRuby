module Load
  def ld_a_a_bc; @a = read_byte(bc); end
  def ld_a_a_de; @a = read_byte(de); end
  def ld_a_a_hl; @a = read_byte(hl); end
  def ld_b_a_hl; @b = read_byte(hl); end
  def ld_c_a_hl; @c = read_byte(hl); end
  def ld_d_a_hl; @d = read_byte(hl); end
  def ld_e_a_hl; @e = read_byte(hl); end
  def ld_h_a_hl; @h = read_byte(hl); end
  def ld_l_a_hl; @l = read_byte(hl); end

  def ld_a_a_c; @a = read_byte((0xFF00 + @c) & 0xFFFF); end
  def ld_a_a_a16; @a = read_byte(pc_read_word); end

  def ld_a_a16_a; write_byte(pc_read_word, @a); end
  def ld_a_a16_sp; write_word(pc_read_word, @sp); end
  def ld_a_c_a; write_byte((0xFF00 + @c) & 0xFFFF, @a); end
  def ld_a_d8; @a = pc_read_byte; end

  def ld_a_bc_a; write_byte(bc, @a); end
  def ld_a_de_a; write_byte(de, @a); end
  def ld_a_hl_a; write_byte(hl, @a); end
  def ld_a_hl_b; write_byte(hl, @b); end
  def ld_a_hl_c; write_byte(hl, @c); end
  def ld_a_hl_d; write_byte(hl, @d); end
  def ld_a_hl_e; write_byte(hl, @e); end
  def ld_a_hl_h; write_byte(hl, @h); end
  def ld_a_hl_l; write_byte(hl, @l); end

  def ld_a_hl_d8; write_byte(hl, pc_read_byte); end

  def ld_a_a; @a = @a; end
  def ld_a_b; @a = @b; end
  def ld_a_c; @a = @c; end
  def ld_a_d; @a = @d; end
  def ld_a_e; @a = @e; end
  def ld_a_h; @a = @h; end
  def ld_a_l; @a = @l; end

  def ld_b_a; @b = @a; end
  def ld_b_b; @b = @b; end
  def ld_b_c; @b = @c; end
  def ld_b_d; @b = @d; end
  def ld_b_e; @b = @e; end
  def ld_b_h; @b = @h; end
  def ld_b_l; @b = @l; end

  def ld_c_a; @c = @a; end
  def ld_c_b; @c = @b; end
  def ld_c_c; @c = @c; end
  def ld_c_d; @c = @d; end
  def ld_c_e; @c = @e; end
  def ld_c_h; @c = @h; end
  def ld_c_l; @c = @l; end

  def ld_d_a; @d = @a; end
  def ld_d_b; @d = @b; end
  def ld_d_c; @d = @c; end
  def ld_d_d; @d = @d; end
  def ld_d_e; @d = @e; end
  def ld_d_h; @d = @h; end
  def ld_d_l; @d = @l; end

  def ld_e_a; @e = @a; end
  def ld_e_b; @e = @b; end
  def ld_e_c; @e = @c; end
  def ld_e_d; @e = @d; end
  def ld_e_e; @e = @e; end
  def ld_e_h; @e = @h; end
  def ld_e_l; @e = @l; end

  def ld_h_a; @h = @a; end
  def ld_h_b; @h = @b; end
  def ld_h_c; @h = @c; end
  def ld_h_d; @h = @d; end
  def ld_h_e; @h = @e; end
  def ld_h_h; @h = @h; end
  def ld_h_l; @h = @l; end

  def ld_l_a; @l = @a; end
  def ld_l_b; @l = @b; end
  def ld_l_c; @l = @c; end
  def ld_l_d; @l = @d; end
  def ld_l_e; @l = @e; end
  def ld_l_h; @l = @h; end
  def ld_l_l; @l = @l; end

  def ld_b_d8; @b = pc_read_byte; end
  def ld_c_d8; @c = pc_read_byte; end
  def ld_d_d8; @d = pc_read_byte; end
  def ld_e_d8; @e = pc_read_byte; end
  def ld_h_d8; @h = pc_read_byte; end
  def ld_l_d8; @l = pc_read_byte; end

  def ld_bc_d16; self.bc = pc_read_word; end
  def ld_de_d16; self.de = pc_read_word; end
  def ld_hl_d16; self.hl = pc_read_word; end
  def ld_sp_d16; @sp = pc_read_word; end

  def ld_sp_hl; @sp = hl; end

  def ld_hl_sp_r8
    offset = pc_read_signed_byte
    set_flags(0, 0, (offset & 0xF) + (@sp & 0xF) >= 0x10, (offset & 0xFF) + (@sp & 0xFF) >= 0x100)
    self.hl = (@sp + offset) & 0xFFFF
  end

  def ldh_a_a_a8; @a = read_byte(0xFF00 + pc_read_byte); end
  def ldh_a_a8_a; write_byte(0xFF00 + pc_read_byte, @a); end

  def ldi_a_a_hl; @a = read_byte(hl); inc_hl; end
  def ldd_a_a_hl; @a = read_byte(hl); dec_hl; end

  def ldi_a_hl_a; write_byte(hl, @a); inc_hl; end
  def ldd_a_hl_a; write_byte(hl, @a); dec_hl; end
end
