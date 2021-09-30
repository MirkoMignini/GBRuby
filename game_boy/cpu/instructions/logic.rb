module Logic
  def and_a; @a &= @a; set_flags(@a == 0, 0, 1, 0); end
  def and_b; @a &= @b; set_flags(@a == 0, 0, 1, 0); end
  def and_c; @a &= @c; set_flags(@a == 0, 0, 1, 0); end
  def and_d; @a &= @d; set_flags(@a == 0, 0, 1, 0); end
  def and_e; @a &= @e; set_flags(@a == 0, 0, 1, 0); end
  def and_h; @a &= @h; set_flags(@a == 0, 0, 1, 0); end
  def and_l; @a &= @l; set_flags(@a == 0, 0, 1, 0); end
  def and_d8; @a &= pc_read_byte; set_flags(@a == 0, 0, 1, 0); end
  def and_a_hl; @a &= read_byte(hl); set_flags(@a == 0, 0, 1, 0); end

  def or_a; @a |= @a; set_flags(@a == 0, 0, 0, 0); end
  def or_b; @a |= @b; set_flags(@a == 0, 0, 0, 0); end
  def or_c; @a |= @c; set_flags(@a == 0, 0, 0, 0); end
  def or_d; @a |= @d; set_flags(@a == 0, 0, 0, 0); end
  def or_e; @a |= @e; set_flags(@a == 0, 0, 0, 0); end
  def or_h; @a |= @h; set_flags(@a == 0, 0, 0, 0); end
  def or_l; @a |= @l; set_flags(@a == 0, 0, 0, 0); end
  def or_d8; @a |= pc_read_byte; set_flags(@a == 0, 0, 0, 0); end
  def or_a_hl; @a |= read_byte(hl); set_flags(@a == 0, 0, 0, 0); end

  def xor_a; @a ^= @a; set_flags(@a == 0, 0, 0, 0); end
  def xor_b; @a ^= @b; set_flags(@a == 0, 0, 0, 0); end
  def xor_c; @a ^= @c; set_flags(@a == 0, 0, 0, 0); end
  def xor_d; @a ^= @d; set_flags(@a == 0, 0, 0, 0); end
  def xor_e; @a ^= @e; set_flags(@a == 0, 0, 0, 0); end
  def xor_h; @a ^= @h; set_flags(@a == 0, 0, 0, 0); end
  def xor_l; @a ^= @l; set_flags(@a == 0, 0, 0, 0); end
  def xor_d8; @a ^= pc_read_byte; set_flags(@a == 0, 0, 0, 0); end
  def xor_a_hl; @a ^= read_byte(hl); set_flags(@a == 0, 0, 0, 0); end
end
