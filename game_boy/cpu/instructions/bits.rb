module Bits
  def bit(index, value) = set_flags(value & (1 << index) == (1 << index), 0, 1, nil)

  def bit_0_a() = bit(0, @a)
  def bit_0_b() = bit(0, @b)
  def bit_0_c() = bit(0, @c)
  def bit_0_d() = bit(0, @d)
  def bit_0_e() = bit(0, @e)
  def bit_0_h() = bit(0, @h)
  def bit_0_l() = bit(0, @l)

  def bit_1_a() = bit(1, @a)
  def bit_1_b() = bit(1, @b)
  def bit_1_c() = bit(1, @c)
  def bit_1_d() = bit(1, @d)
  def bit_1_e() = bit(1, @e)
  def bit_1_h() = bit(1, @h)
  def bit_1_l() = bit(1, @l)

  def bit_2_a() = bit(2, @a)
  def bit_2_b() = bit(2, @b)
  def bit_2_c() = bit(2, @c)
  def bit_2_d() = bit(2, @d)
  def bit_2_e() = bit(2, @e)
  def bit_2_h() = bit(2, @h)
  def bit_2_l() = bit(2, @l)

  def bit_3_a() = bit(3, @a)
  def bit_3_b() = bit(3, @b)
  def bit_3_c() = bit(3, @c)
  def bit_3_d() = bit(3, @d)
  def bit_3_e() = bit(3, @e)
  def bit_3_h() = bit(3, @h)
  def bit_3_l() = bit(3, @l)

  def bit_4_a() = bit(4, @a)
  def bit_4_b() = bit(4, @b)
  def bit_4_c() = bit(4, @c)
  def bit_4_d() = bit(4, @d)
  def bit_4_e() = bit(4, @e)
  def bit_4_h() = bit(4, @h)
  def bit_4_l() = bit(4, @l)

  def bit_5_a() = bit(5, @a)
  def bit_5_b() = bit(5, @b)
  def bit_5_c() = bit(5, @c)
  def bit_5_d() = bit(5, @d)
  def bit_5_e() = bit(5, @e)
  def bit_5_h() = bit(5, @h)
  def bit_5_l() = bit(5, @l)

  def bit_6_a() = bit(6, @a)
  def bit_6_b() = bit(6, @b)
  def bit_6_c() = bit(6, @c)
  def bit_6_d() = bit(6, @d)
  def bit_6_e() = bit(6, @e)
  def bit_6_h() = bit(6, @h)
  def bit_6_l() = bit(6, @l)

  def bit_7_a() = bit(7, @a)
  def bit_7_b() = bit(7, @b)
  def bit_7_c() = bit(7, @c)
  def bit_7_d() = bit(7, @d)
  def bit_7_e() = bit(7, @e)
  def bit_7_h() = bit(7, @h)
  def bit_7_l() = bit(7, @l)

  def bit_0_a_hl() = bit(0, read_byte(hl))
  def bit_1_a_hl() = bit(1, read_byte(hl))
  def bit_2_a_hl() = bit(2, read_byte(hl))
  def bit_3_a_hl() = bit(3, read_byte(hl))
  def bit_4_a_hl() = bit(4, read_byte(hl))
  def bit_5_a_hl() = bit(5, read_byte(hl))
  def bit_6_a_hl() = bit(6, read_byte(hl))
  def bit_7_a_hl() = bit(7, read_byte(hl))

  def set(index, value); end
  def set_0_a_hl; write_byte(hl, read_byte(hl) | 1); end
  def set_1_a_hl; write_byte(hl, read_byte(hl) | 2); end
  def set_2_a_hl; write_byte(hl, read_byte(hl) | 4); end
  def set_3_a_hl; write_byte(hl, read_byte(hl) | 8); end
  def set_4_a_hl; write_byte(hl, read_byte(hl) | 16); end
  def set_5_a_hl; write_byte(hl, read_byte(hl) | 32); end
  def set_6_a_hl; write_byte(hl, read_byte(hl) | 64); end
  def set_7_a_hl; write_byte(hl, read_byte(hl) | 128); end

  def set_0_a; @a |= 1; end
  def set_0_b; @b |= 1; end
  def set_0_c; @c |= 1; end
  def set_0_d; @d |= 1; end
  def set_0_e; @e |= 1; end
  def set_0_h; @h |= 1; end
  def set_0_l; @l |= 1; end

  def set_1_a; @a |= 2; end
  def set_1_b; @b |= 2; end
  def set_1_c; @c |= 2; end
  def set_1_d; @d |= 2; end
  def set_1_e; @e |= 2; end
  def set_1_h; @h |= 2; end
  def set_1_l; @l |= 2; end

  def set_2_a; @a |= 4; end
  def set_2_b; @b |= 4; end
  def set_2_c; @c |= 4; end
  def set_2_d; @d |= 4; end
  def set_2_e; @e |= 4; end
  def set_2_h; @h |= 4; end
  def set_2_l; @l |= 4; end

  def set_3_a; @a |= 8; end
  def set_3_b; @b |= 8; end
  def set_3_c; @c |= 8; end
  def set_3_d; @d |= 8; end
  def set_3_e; @e |= 8; end
  def set_3_h; @h |= 8; end
  def set_3_l; @l |= 8; end

  def set_4_a; @a |= 16; end
  def set_4_b; @b |= 16; end
  def set_4_c; @c |= 16; end
  def set_4_d; @d |= 16; end
  def set_4_e; @e |= 16; end
  def set_4_h; @h |= 16; end
  def set_4_l; @l |= 16; end

  def set_5_a; @a |= 32; end
  def set_5_b; @b |= 32; end
  def set_5_c; @c |= 32; end
  def set_5_d; @d |= 32; end
  def set_5_e; @e |= 32; end
  def set_5_h; @h |= 32; end
  def set_5_l; @l |= 32; end

  def set_6_a; @a |= 64; end
  def set_6_b; @b |= 64; end
  def set_6_c; @c |= 64; end
  def set_6_d; @d |= 64; end
  def set_6_e; @e |= 64; end
  def set_6_h; @h |= 64; end
  def set_6_l; @l |= 64; end

  def set_7_a; @a |= 128; end
  def set_7_b; @b |= 128; end
  def set_7_c; @c |= 128; end
  def set_7_d; @d |= 128; end
  def set_7_e; @e |= 128; end
  def set_7_h; @h |= 128; end
  def set_7_l; @l |= 128; end

  def res_0_a; @a &= 0b11111110; end
  def res_0_b; @b &= 0b11111110; end
  def res_0_c; @c &= 0b11111110; end
  def res_0_d; @d &= 0b11111110; end
  def res_0_e; @e &= 0b11111110; end
  def res_0_h; @h &= 0b11111110; end
  def res_0_l; @l &= 0b11111110; end

  def res_1_a; @a &= 0b11111101; end
  def res_1_b; @b &= 0b11111101; end
  def res_1_c; @c &= 0b11111101; end
  def res_1_d; @d &= 0b11111101; end
  def res_1_e; @e &= 0b11111101; end
  def res_1_h; @h &= 0b11111101; end
  def res_1_l; @l &= 0b11111101; end

  def res_2_a; @a &= 0b11111011; end
  def res_2_b; @b &= 0b11111011; end
  def res_2_c; @c &= 0b11111011; end
  def res_2_d; @d &= 0b11111011; end
  def res_2_e; @e &= 0b11111011; end
  def res_2_h; @h &= 0b11111011; end
  def res_2_l; @l &= 0b11111011; end

  def res_3_a; @a &= 0b11110111; end
  def res_3_b; @b &= 0b11110111; end
  def res_3_c; @c &= 0b11110111; end
  def res_3_d; @d &= 0b11110111; end
  def res_3_e; @e &= 0b11110111; end
  def res_3_h; @h &= 0b11110111; end
  def res_3_l; @l &= 0b11110111; end

  def res_4_a; @a &= 0b11101111; end
  def res_4_b; @b &= 0b11101111; end
  def res_4_c; @c &= 0b11101111; end
  def res_4_d; @d &= 0b11101111; end
  def res_4_e; @e &= 0b11101111; end
  def res_4_h; @h &= 0b11101111; end
  def res_4_l; @l &= 0b11101111; end

  def res_5_a; @a &= 0b11011111; end
  def res_5_b; @b &= 0b11011111; end
  def res_5_c; @c &= 0b11011111; end
  def res_5_d; @d &= 0b11011111; end
  def res_5_e; @e &= 0b11011111; end
  def res_5_h; @h &= 0b11011111; end
  def res_5_l; @l &= 0b11011111; end

  def res_6_a; @a &= 0b10111111; end
  def res_6_b; @b &= 0b10111111; end
  def res_6_c; @c &= 0b10111111; end
  def res_6_d; @d &= 0b10111111; end
  def res_6_e; @e &= 0b10111111; end
  def res_6_h; @h &= 0b10111111; end
  def res_6_l; @l &= 0b10111111; end

  def res_7_a; @a &= 0b01111111; end
  def res_7_b; @b &= 0b01111111; end
  def res_7_c; @c &= 0b01111111; end
  def res_7_d; @d &= 0b01111111; end
  def res_7_e; @e &= 0b01111111; end
  def res_7_h; @h &= 0b01111111; end
  def res_7_l; @l &= 0b01111111; end

  def res_0_a_hl; write_byte(hl, read_byte(hl) & 0b11111110); end
  def res_1_a_hl; write_byte(hl, read_byte(hl) & 0b11111101); end
  def res_2_a_hl; write_byte(hl, read_byte(hl) & 0b11111011); end
  def res_3_a_hl; write_byte(hl, read_byte(hl) & 0b11110111); end
  def res_4_a_hl; write_byte(hl, read_byte(hl) & 0b11101111); end
  def res_5_a_hl; write_byte(hl, read_byte(hl) & 0b11011111); end
  def res_6_a_hl; write_byte(hl, read_byte(hl) & 0b10111111); end
  def res_7_a_hl; write_byte(hl, read_byte(hl) & 0b01111111); end
end
