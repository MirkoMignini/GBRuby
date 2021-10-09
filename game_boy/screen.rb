class Screen
  WINDOW_WIDTH = 480
  WINDOW_HEIGHT = 432

  SCREEN_WIDTH = 160
  SCREEN_HEIGHT = 144

  def initialize
    SDL.InitSubSystem SDL::INIT_VIDEO
    @buffer = FFI::MemoryPointer.new :uint32, SCREEN_WIDTH * SCREEN_HEIGHT
    @window = SDL.CreateWindow 'GBRuby', 0, 0, WINDOW_WIDTH, WINDOW_HEIGHT, SDL::SDL_WINDOW_RESIZABLE
    @renderer = SDL.CreateRenderer @window, -1, 0
    SDL.SetHint("SDL_HINT_RENDER_SCALE_QUALITY", "2")
    SDL.RenderSetLogicalSize(@renderer, WINDOW_WIDTH, WINDOW_HEIGHT)
    @texture = SDL.CreateTexture @renderer, SDL::PIXELFORMAT_ARGB8888, 1, SCREEN_WIDTH, SCREEN_HEIGHT
    @last = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    @event = FFI::MemoryPointer.new(:uint32, 16)

    @titles = (0..200).map {|n| "GBRuby (%d fps)" % n }
  end

  def render(framebuffer)
    t = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    fps = 1.0 / (t - @last)
    fps = fps.floor
    @last = t

    @buffer.write_array_of_uint32 framebuffer
    SDL.UpdateTexture @texture, nil, @buffer, SCREEN_WIDTH * 4
    SDL.RenderClear @renderer
    SDL.RenderCopy @renderer, @texture, nil, nil
    SDL.RenderPresent @renderer

    while SDL.PollEvent(@event) != 0
      case @event.read_int
      when 0x100 # SDL_QUIT
        exit
      end
    end

    fps = 200 if fps > 200
    SDL.SetWindowTitle(@window, @titles[fps])
  end
end
