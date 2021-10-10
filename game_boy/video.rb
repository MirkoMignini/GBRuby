class Video
  WINDOW_WIDTH = 480
  WINDOW_HEIGHT = 432

  SCREEN_WIDTH = 160
  SCREEN_HEIGHT = 144

  def initialize
    SDL2.InitSubSystem SDL2::INIT_VIDEO
    @buffer = FFI::MemoryPointer.new :uint32, SCREEN_WIDTH * SCREEN_HEIGHT
    @window = SDL2.CreateWindow 'GBRuby', 0, 0, WINDOW_WIDTH, WINDOW_HEIGHT, SDL2::WINDOW_RESIZABLE
    @renderer = SDL2.CreateRenderer @window, -1, 0
    SDL2.SetHint("SDL_HINT_RENDER_SCALE_QUALITY", "linear")
    SDL2.RenderSetLogicalSize(@renderer, WINDOW_WIDTH, WINDOW_HEIGHT)
    @texture = SDL2.CreateTexture @renderer, SDL2::PIXELFORMAT_ARGB8888, 1, SCREEN_WIDTH, SCREEN_HEIGHT
    @last = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    @event = FFI::MemoryPointer.new(:uint32, 16)

    @titles = (0..200).map {|n| "GBRuby (%d fps)" % n }
  end

  def dispose
    SDL2.DestroyTexture(@texture)
    SDL2.DestroyRenderer(@renderer)
    SDL2.DestroyWindow(@window)
    SDL2.QuitSubSystem(SDL2::INIT_VIDEO)
  end

  def render(framebuffer)
    t = Process.clock_gettime(Process::CLOCK_MONOTONIC)
    fps = 1.0 / (t - @last)
    fps = fps.floor
    @last = t

    @buffer.write_array_of_uint32 framebuffer
    SDL2.UpdateTexture @texture, nil, @buffer, SCREEN_WIDTH * 4
    SDL2.RenderClear @renderer
    SDL2.RenderCopy @renderer, @texture, nil, nil
    SDL2.RenderPresent @renderer

    while SDL2.PollEvent(@event) != 0
      case @event.read_int
      when 0x100 # SDL_QUIT
        exit
      end
    end

    fps = 200 if fps > 200
    SDL2.SetWindowTitle(@window, @titles[fps])
  end
end
