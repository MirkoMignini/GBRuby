require 'bit-twiddle/core_ext'

require_relative 'instructions/bits'
require_relative 'instructions/flow'
require_relative 'instructions/load'
require_relative 'instructions/logic'
require_relative 'instructions/math'
require_relative 'instructions/miscellaneous'
require_relative 'instructions/rotate_and_shift'

module Instructions
  include Bits
  include Flow
  include Load
  include Logic
  include Math
  include Miscellaneous
  include RotateAndShift
end
