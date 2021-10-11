module Bits
  def bit(index, value) = set_flags(value & (1 << index) == 0, 0, 1, nil)

  def bit_0_a() = set_flags(@a & 1 == 0, 0, 1, nil)
  def bit_0_b() = set_flags(@b & 1 == 0, 0, 1, nil)
  def bit_0_c() = set_flags(@c & 1 == 0, 0, 1, nil)
  def bit_0_d() = set_flags(@d & 1 == 0, 0, 1, nil)
  def bit_0_e() = set_flags(@e & 1 == 0, 0, 1, nil)
  def bit_0_h() = set_flags(@h & 1 == 0, 0, 1, nil)
  def bit_0_l() = set_flags(@l & 1 == 0, 0, 1, nil)

  def bit_1_a() = set_flags(@a & 2 == 0, 0, 1, nil)
  def bit_1_b() = set_flags(@b & 2 == 0, 0, 1, nil)
  def bit_1_c() = set_flags(@c & 2 == 0, 0, 1, nil)
  def bit_1_d() = set_flags(@d & 2 == 0, 0, 1, nil)
  def bit_1_e() = set_flags(@e & 2 == 0, 0, 1, nil)
  def bit_1_h() = set_flags(@h & 2 == 0, 0, 1, nil)
  def bit_1_l() = set_flags(@l & 2 == 0, 0, 1, nil)

  def bit_2_a() = set_flags(@a & 4 == 0, 0, 1, nil)
  def bit_2_b() = set_flags(@b & 4 == 0, 0, 1, nil)
  def bit_2_c() = set_flags(@c & 4 == 0, 0, 1, nil)
  def bit_2_d() = set_flags(@d & 4 == 0, 0, 1, nil)
  def bit_2_e() = set_flags(@e & 4 == 0, 0, 1, nil)
  def bit_2_h() = set_flags(@h & 4 == 0, 0, 1, nil)
  def bit_2_l() = set_flags(@l & 4 == 0, 0, 1, nil)

  def bit_3_a() = set_flags(@a & 8 == 0, 0, 1, nil)
  def bit_3_b() = set_flags(@b & 8 == 0, 0, 1, nil)
  def bit_3_c() = set_flags(@c & 8 == 0, 0, 1, nil)
  def bit_3_d() = set_flags(@d & 8 == 0, 0, 1, nil)
  def bit_3_e() = set_flags(@e & 8 == 0, 0, 1, nil)
  def bit_3_h() = set_flags(@h & 8 == 0, 0, 1, nil)
  def bit_3_l() = set_flags(@l & 8 == 0, 0, 1, nil)

  def bit_4_a() = set_flags(@a & 16 == 0, 0, 1, nil)
  def bit_4_b() = set_flags(@b & 16 == 0, 0, 1, nil)
  def bit_4_c() = set_flags(@c & 16 == 0, 0, 1, nil)
  def bit_4_d() = set_flags(@d & 16 == 0, 0, 1, nil)
  def bit_4_e() = set_flags(@e & 16 == 0, 0, 1, nil)
  def bit_4_h() = set_flags(@h & 16 == 0, 0, 1, nil)
  def bit_4_l() = set_flags(@l & 16 == 0, 0, 1, nil)

  def bit_5_a() = set_flags(@a & 32 == 0, 0, 1, nil)
  def bit_5_b() = set_flags(@b & 32 == 0, 0, 1, nil)
  def bit_5_c() = set_flags(@c & 32 == 0, 0, 1, nil)
  def bit_5_d() = set_flags(@d & 32 == 0, 0, 1, nil)
  def bit_5_e() = set_flags(@e & 32 == 0, 0, 1, nil)
  def bit_5_h() = set_flags(@h & 32 == 0, 0, 1, nil)
  def bit_5_l() = set_flags(@l & 32 == 0, 0, 1, nil)

  def bit_6_a() = set_flags(@a & 64 == 0, 0, 1, nil)
  def bit_6_b() = set_flags(@b & 64 == 0, 0, 1, nil)
  def bit_6_c() = set_flags(@c & 64 == 0, 0, 1, nil)
  def bit_6_d() = set_flags(@d & 64 == 0, 0, 1, nil)
  def bit_6_e() = set_flags(@e & 64 == 0, 0, 1, nil)
  def bit_6_h() = set_flags(@h & 64 == 0, 0, 1, nil)
  def bit_6_l() = set_flags(@l & 64 == 0, 0, 1, nil)

  def bit_7_a() = set_flags(@a & 128 == 0, 0, 1, nil)
  def bit_7_b() = set_flags(@b & 128 == 0, 0, 1, nil)
  def bit_7_c() = set_flags(@c & 128 == 0, 0, 1, nil)
  def bit_7_d() = set_flags(@d & 128 == 0, 0, 1, nil)
  def bit_7_e() = set_flags(@e & 128 == 0, 0, 1, nil)
  def bit_7_h() = set_flags(@h & 128 == 0, 0, 1, nil)
  def bit_7_l() = set_flags(@l & 128 == 0, 0, 1, nil)

  def bit_0_a_hl() = bit(0, read_byte(hl))
  def bit_1_a_hl() = bit(1, read_byte(hl))
  def bit_2_a_hl() = bit(2, read_byte(hl))
  def bit_3_a_hl() = bit(3, read_byte(hl))
  def bit_4_a_hl() = bit(4, read_byte(hl))
  def bit_5_a_hl() = bit(5, read_byte(hl))
  def bit_6_a_hl() = bit(6, read_byte(hl))
  def bit_7_a_hl() = bit(7, read_byte(hl))

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
