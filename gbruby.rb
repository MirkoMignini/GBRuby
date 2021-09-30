require_relative 'game_boy'
require_relative 'cartridge'

game_boy = GameBoy.new
# cartridge = Cartridge.new('roms/tetris.gb')
# cartridge = Cartridge.new('roms/dmg-acid2.gb')
# cartridge = Cartridge.new('roms/01-special.gb')                   # PASS
# cartridge = Cartridge.new('roms/02-interrupts.gb')                # PASS
# cartridge = Cartridge.new('roms/03-op sp,hl.gb')                  # PASS
# cartridge = Cartridge.new('roms/04-op r,imm.gb')                  # PASS
# cartridge = Cartridge.new('roms/05-op rp.gb')                     # PASS
# cartridge = Cartridge.new('roms/06-ld r,r.gb')                    # PASS
# cartridge = Cartridge.new('roms/07-jr,jp,call,ret,rst.gb')        # PASS
# cartridge = Cartridge.new('roms/08-misc instrs.gb')               # PASS
# cartridge = Cartridge.new('roms/09-op r,r.gb')                    # PASS
# cartridge = Cartridge.new('roms/10-bit ops.gb')                   # PASS
# cartridge = Cartridge.new('roms/11-op a,(hl).gb')                 # PASS
# cartridge = Cartridge.new('roms/interrupt_time.gb')
# cartridge = Cartridge.new('roms/instr_timing.gb')
game_boy.load_cartridge(cartridge)
game_boy.play(boot: false)
