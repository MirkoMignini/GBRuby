require_relative 'game_boy'
require_relative 'cartridge'
require 'stackprof'

game_boy = GameBoy.new
# cartridge = Cartridge.new('roms/DMG_ROM.gb')
# cartridge = Cartridge.new('roms/boot_div-dmg0.gb')
# cartridge = Cartridge.new('roms/daa.gb')
# cartridge = Cartridge.new('roms/merken.gb')
cartridge = Cartridge.new('roms/Super Mario Land.gb')
# cartridge = Cartridge.new('roms/Super Mario Land 2.gb')
# cartridge = Cartridge.new('roms/sprite_priority.gb')
# cartridge = Cartridge.new("roms/The Legend of Zelda - Link's Awakening.gb")
# cartridge = Cartridge.new('roms/tetris.gb')
# cartridge = Cartridge.new('roms/Super R.C. Pro-Am (USA, Europe).gb')
# cartridge = Cartridge.new('roms/tennis.gb')
# cartridge = Cartridge.new('roms/Marble Madness.gb')
# cartridge = Cartridge.new("roms/Kirby's Dream Land.gb")
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
# cartridge = Cartridge.new('roms/cputest.gb')
# cartridge = Cartridge.new('roms/Pokemon Red.gb')
# cartridge = Cartridge.new('roms/Pokemon Blue.gb')
game_boy.load_cartridge(cartridge)

StackProf.start(mode: :cpu)
begin
  game_boy.play(boot: false)
ensure
  StackProf.stop
  StackProf.results('stackprof.dump')
  game_boy.dispose

  puts "Average FPS: #{game_boy.ppu.video.avg_fps} after #{game_boy.ppu.video.frames_counter} frames."
end
