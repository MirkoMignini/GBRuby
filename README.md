# GBRuby

GBRuby is another Game Boy emulator, written in ruby.

## Requirements

- Ruby 3
- SDL 2

## Install SDL2 on macos

    $ brew install sdl2
    $ brew install sdl2_image
    $ brew install sdl2_mixer
    $ brew install sdl2_ttf

## How to use it?

Initialize the Game Boy, choose a cartridge, load it, and play!

    $ game_boy = GameBoy.new
    $ cartridge = Cartridge.new('roms/tetris.gb')
    $ game_boy.load_cartridge(cartridge)
    $ game_boy.play(boot: false)
