module Flow
  def call(condition)
    address = pc_read_word
    return unless condition

    push(@pc)
    @pc = address
    @jump = true
  end
  def call_a16;    call(true); end
  def call_c_a16;  call(flag_c?); end
  def call_nc_a16; call(flag_nc?); end
  def call_nz_a16; call(flag_nz?); end
  def call_z_a16;  call(flag_z?); end

  def jump(condition, address)
    return unless condition

    @pc = address
    @jump = true
  end
  def jp_a16;    jump(true,     pc_read_word); end
  def jp_a_hl;   jump(true,     hl); end
  def jp_c_a16;  jump(flag_c?,  pc_read_word); end
  def jp_z_a16;  jump(flag_z?,  pc_read_word); end
  def jp_nc_a16; jump(flag_nc?, pc_read_word); end
  def jp_nz_a16; jump(flag_nz?, pc_read_word); end
  def jr_r8;     jump(true,     pc_read_signed_byte + @pc & 0xFFFF); end
  def jr_c_r8;   jump(flag_c? , pc_read_signed_byte + @pc & 0xFFFF); end
  def jr_z_r8;   jump(flag_z? , pc_read_signed_byte + @pc & 0xFFFF); end
  def jr_nc_r8;  jump(flag_nc?, pc_read_signed_byte + @pc & 0xFFFF); end
  def jr_nz_r8;  jump(flag_nz?, pc_read_signed_byte + @pc & 0xFFFF); end

  def pop; address = read_word(@sp); @sp += 2; address; end
  def pop_af; self.af = pop; end
  def pop_bc; self.bc = pop; end
  def pop_de; self.de = pop; end
  def pop_hl; self.hl = pop; end

  def push(address); write_byte(@sp -= 1, address >> 8); write_byte(@sp -= 1, address & 0xFF); end
  def push_af; push(af); end
  def push_bc; push(bc); end
  def push_de; push(de); end
  def push_hl; push(hl); end

  def rst_00h; push(@pc); @pc = 0x00; end
  def rst_08h; push(@pc); @pc = 0x08; end
  def rst_10h; push(@pc); @pc = 0x10; end
  def rst_18h; push(@pc); @pc = 0x18; end
  def rst_20h; push(@pc); @pc = 0x20; end
  def rst_28h; push(@pc); @pc = 0x28; end
  def rst_30h; push(@pc); @pc = 0x30; end
  def rst_38h; push(@pc); @pc = 0x38; end

  def ret;    @pc = pop; @jump = true; end
  def ret_c;  ret if flag_c?; end
  def ret_nc; ret if flag_nc?; end
  def ret_nz; ret if flag_nz?; end
  def ret_z;  ret if flag_z?; end
  def reti; @pc = pop; @jump = true; ei; end

  # TODO: There is a bug in DMG causing the opcode after halt repeated twice, not reproduced currently
  def halt
    @halted = true
  end

  def stop_0; pc_read_byte; end
end
