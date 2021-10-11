require_relative 'game_boy'
require_relative 'cartridge'
require 'stackprof'

game_boy = GameBoy.new
# cartridge = Cartridge.new('roms/DMG_ROM.gb')
# cartridge = Cartridge.new('roms/tetris.gb')
# cartridge = Cartridge.new('roms/Hyper Lode Runner.gb')
# cartridge = Cartridge.new('roms/Dr. Mario.gb')
# cartridge = Cartridge.new('roms/Bubble Ghost.gb')
# cartridge = Cartridge.new('roms/dmg-acid2.gb')
# cartridge = Cartridge.new('roms/bgbtest.gb')
# cartridge = Cartridge.new('roms/01-special.gb')
# cartridge = Cartridge.new('roms/02-interrupts.gb')
# cartridge = Cartridge.new('roms/03-op sp,hl.gb')
# cartridge = Cartridge.new('roms/04-op r,imm.gb')
# cartridge = Cartridge.new('roms/05-op rp.gb')
# cartridge = Cartridge.new('roms/06-ld r,r.gb')
# cartridge = Cartridge.new('roms/07-jr,jp,call,ret,rst.gb')
# cartridge = Cartridge.new('roms/08-misc instrs.gb')
# cartridge = Cartridge.new('roms/09-op r,r.gb')
# cartridge = Cartridge.new('roms/10-bit ops.gb')
# cartridge = Cartridge.new('roms/11-op a,(hl).gb')
# cartridge = Cartridge.new('roms/interrupt_time.gb')
# cartridge = Cartridge.new('roms/instr_timing.gb')
game_boy.load_cartridge(cartridge)

# StackProf.start(mode: :cpu)
# begin
  game_boy.play(boot: false)
# ensure
#   StackProf.stop
#   StackProf.results('stackprof.dump')
# end
