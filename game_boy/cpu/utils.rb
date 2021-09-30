module Utils
  def signed_byte(value)
    value > 127 ? -256 + value : value
  end
end
