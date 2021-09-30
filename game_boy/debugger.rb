module Debugger
  # def save_asm(filename)
  #   return nil unless @cart

  #   File.open(filename, 'w') do |f|
  #     address = 0
  #     while (address < @cart.rom.size)
  #       instruction = Instruction.new(self, address)
  #       address += instruction.length
  #       f.puts(debug_instruction(instruction))
  #     end
  #   end
  # end

  # def debug_instruction(instruction)
  #   "%s:%04X %-16s %-4s %s" % [
  #     instruction.address <= 0x3FFF ? 'ROM0' : 'ROM1',
  #     instruction.address,
  #     instruction.bytecodes.collect { |byte| ("%02X" % [byte]) }.join(' '),
  #     instruction.mnemonic,
  #     instruction.operands.map(&:text).join(',')
  #   ]
  # end

  # def debug_instruction(pc, instruction)
  #   "%04X %02X %02X %02X %10s AF:%04X BC:%04X DE:%04X HL:%04X SP:%04X Z:%s N:%s H:%s C:%s" % [
  #     pc, read_byte(pc), read_byte(pc + 1), read_byte(pc + 2), instruction[:method],
  #     @af, @bc, @de, @hl, @sp, flag_z_bit, flag_h_bit, flag_h_bit, flag_c_bit
  #   ]
  # end

  def skip_boot
    # set cpu register state
    @cpu.register_set('PC', 0x0100)
    @cpu.register_set('AF', 0x01B0)
    @cpu.register_set('BC', 0x0013)
    @cpu.register_set('DE', 0x00D8)
    @cpu.register_set('HL', 0x014D)
    @cpu.register_set('SP', 0xFFFE)

    # set IO reigster state
    write_byte(0xFF10, 0x80)
    write_byte(0xFF11, 0xBF)
    write_byte(0xFF12, 0xF3)
    write_byte(0xFF14, 0xBF)
    write_byte(0xFF16, 0x3F)
    write_byte(0xFF19, 0xBF)
    write_byte(0xFF1A, 0x7F)
    write_byte(0xFF1B, 0xFF)
    write_byte(0xFF1C, 0x9F)
    write_byte(0xFF1E, 0xBF)
    write_byte(0xFF20, 0xFF)
    write_byte(0xFF23, 0xBF)
    write_byte(0xFF24, 0x77)
    write_byte(0xFF25, 0xF3)
    write_byte(0xFF26, 0xF1)
    write_byte(0xFF40, 0x91)
    write_byte(0xFF41, 0x05)
    write_byte(0xFF47, 0xFC)
    write_byte(0xFF48, 0xFF)
    write_byte(0xFF49, 0xFF)

    # unmap the boot rom
    write_byte(0xFF50, 0x01)
  end
end
