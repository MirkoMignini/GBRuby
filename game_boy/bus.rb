require_relative 'mmu/hram'
require_relative 'mmu/io_registers'
require_relative 'mmu/oam'
require_relative 'mmu/vram'
require_relative 'mmu/wram'

module BUS
  CART_ROM_ADDRESS      = 0x0000.freeze
  VRAM_ADDRESS          = 0x8000.freeze
  CART_RAM_ADDRESS      = 0xA000.freeze
  WRAM_ADDRESS          = 0xC000.freeze
  ECHO_ADDRESS          = 0xE000.freeze
  OAM_ADDRESS           = 0xFE00.freeze
  NOT_USABLE_ADDRESS    = 0xFEA0.freeze
  IO_REGISTERS_ADDRESS  = 0xFF00.freeze
  HRAM_ADDRESS          = 0xFF80.freeze

  attr_reader :io_registers, :hram

  def init_bus
    @vram = VRAM.new(self)
    @wram = WRAM.new(self)
    @oam = OAM.new(self)
    @io_registers = IORegisters.new(self)
    @hram = HRAM.new(self)
  end

  def read_byte(address)
    # raise StandardError.new('Cannot read address %04X' % [address]) if address > 0xFFFF || address < 0

    if ( address < VRAM_ADDRESS )
      @cartridge.read_rom_byte(address)
    elsif address < CART_RAM_ADDRESS
      @vram.read_byte(address)
    elsif address < WRAM_ADDRESS
      @cartridge.read_ram_byte(address)
    elsif address < ECHO_ADDRESS
      @wram.read_byte(address)
    elsif address < OAM_ADDRESS
      @wram.read_byte(address - 0x2000)
    elsif address < NOT_USABLE_ADDRESS
      @oam.read_byte(address)
    elsif address < IO_REGISTERS_ADDRESS
    elsif address < HRAM_ADDRESS
      @io_registers.read_byte(address)
    else
      @hram.read_byte(address)
    end
  end

  def read_word(address)
    (read_byte(address + 1) << 8) + read_byte(address)
  end

  def write_byte(address, value)
    # raise 'BUS cannot write null or not int value to address 0x%04X, %s' % [address, value] if value.nil? || !value.is_a?(Integer)
    # raise 'BUS cannot write %02X to address 0x%04X' % [value, address] if value < 0 || value > 0xFF

    if ( address < VRAM_ADDRESS )
      @cartridge.write_rom_byte(address, value)
    elsif address < CART_RAM_ADDRESS
      @vram.write_byte(address, value)
    elsif address < WRAM_ADDRESS
      @cartridge.write_ram_byte(address, value)
    elsif address < ECHO_ADDRESS
      @wram.write_byte(address, value)
    elsif address < OAM_ADDRESS
      @wram.write_byte(address - 0x2000, value)
    elsif address < NOT_USABLE_ADDRESS
      @oam.write_byte(address, value)
    elsif address < IO_REGISTERS_ADDRESS
    elsif address < HRAM_ADDRESS
      @io_registers.write_byte(address, value)
    else
      @hram.write_byte(address, value)
    end
  end
end
