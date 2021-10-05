require 'byebug'

module Registers
  Z_MASK      = 0b10000000
  N_MASK      = 0b01000000
  H_MASK      = 0b00100000
  C_MASK      = 0b00010000

  def setup_registers
    @pc = 0x0100
    @sp = 0xFFFE
    @a = @f = @b = @c = @d = @e = @h = @l = 0x0
  end

  def af=(value); @a = (value >> 8); @f = (value & 0xF0); end
  def bc=(value); @b = (value >> 8); @c = (value & 0xFF); end
  def de=(value); @d = (value >> 8); @e = (value & 0xFF); end
  def hl=(value); @h = (value >> 8); @l = (value & 0xFF); end

  def af; (@a << 8) + @f; end
  def bc; (@b << 8) + @c; end
  def de; (@d << 8) + @e; end
  def hl; (@h << 8) + @l; end

  def register_set(reg, value)
    raise "Cannot set null value to #{reg}." if value.nil?

    case reg
    when 'A' then @a = value
    when 'B' then @b = value
    when 'D' then @d = value
    when 'H' then @h = value
    when 'F' then @f = value
    when 'C' then @c = value
    when 'E' then @e = value
    when 'L' then @l = value
    when 'AF' then @a = (value >> 8); @f = (value & 0xFF)
    when 'BC' then @b = (value >> 8); @c = (value & 0xFF)
    when 'DE' then @d = (value >> 8); @e = (value & 0xFF)
    when 'HL' then @h = (value >> 8); @l = (value & 0xFF)
    when 'PC' then @pc = value
    when 'SP' then @sp = value
    else raise "Unknown register #{reg}."
    end
  end

  # # Flags

  def reset_flags
    @f = 0
  end

  def set_flags(z, n, h, c)
    ((z == true || z == 1) ? @f |= Z_MASK : @f = @f & ~Z_MASK) if z != nil
    ((n == true || n == 1) ? @f |= N_MASK : @f = @f & ~N_MASK) if n != nil
    ((h == true || h == 1) ? @f |= H_MASK : @f = @f & ~H_MASK) if h != nil
    ((c == true || c == 1) ? @f |= C_MASK : @f = @f & ~C_MASK) if c != nil
  end

  def flag_nz?; (@f & Z_MASK) == 0; end
  def flag_nc?; (@f & C_MASK) == 0; end

  def flag_z?; (@f & Z_MASK) != 0; end
  def flag_n?; (@f & N_MASK) != 0; end
  def flag_h?; (@f & H_MASK) != 0; end
  def flag_c?; (@f & C_MASK) != 0; end

  def flag_z_bit; @f & Z_MASK == 0 ? 0 : 1; end
  def flag_n_bit; @f & N_MASK == 0 ? 0 : 1; end
  def flag_h_bit; @f & H_MASK == 0 ? 0 : 1; end
  def flag_c_bit; @f & C_MASK == 0 ? 0 : 1; end
end
