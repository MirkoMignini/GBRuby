module Logic
  def _and(value); @a &= value; set_flags(@a == 0, 0, 1, 0); end
  def and_a()= _and(@a)
  def and_b()= _and(@b)
  def and_c()= _and(@c)
  def and_d()= _and(@d)
  def and_e()= _and(@e)
  def and_h()= _and(@h)
  def and_l()= _and(@l)
  def and_d8()= _and(pc_read_byte)
  def and_a_hl()= _and(read_byte(hl))

  def _or(value); @a |= value; set_flags(@a == 0, 0, 0, 0); end
  def or_a()= _or(@a)
  def or_b()= _or(@b)
  def or_c()= _or(@c)
  def or_d()= _or(@d)
  def or_e()= _or(@e)
  def or_h()= _or(@h)
  def or_l()= _or(@l)
  def or_d8()= _or(pc_read_byte)
  def or_a_hl()= _or(read_byte(hl))

  def xor(value); @a ^= value; set_flags(@a == 0, 0, 0, 0); end
  def xor_a()= xor(@a)
  def xor_b()= xor(@b)
  def xor_c()= xor(@c)
  def xor_d()= xor(@d)
  def xor_e()= xor(@e)
  def xor_h()= xor(@h)
  def xor_l()= xor(@l)
  def xor_d8()= xor(pc_read_byte)
  def xor_a_hl()= xor(read_byte(hl))
end
