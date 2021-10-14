class Video
  WINDOW_WIDTH = 480
  WINDOW_HEIGHT = 432

  SCREEN_WIDTH = 160
  SCREEN_HEIGHT = 144

  attr_reader :total_fps, :frames_counter
  attr_accessor :frames_limit

  def initialize
    SDL2.InitSubSystem SDL2::INIT_VIDEO
    @buffer = FFI::MemoryPointer.new :uint32, SCREEN_WIDTH * SCREEN_HEIGHT
    @window = SDL2.CreateWindow 'GBRuby', 0, 0, WINDOW_WIDTH, WINDOW_HEIGHT, SDL2::WINDOW_RESIZABLE #| SDL2::WINDOW_HIDDEN
    @renderer = SDL2.CreateRenderer @window, -1, 0
    SDL2.SetHint("SDL_HINT_RENDER_SCALE_QUALITY", "linear")
    SDL2.RenderSetLogicalSize(@renderer, WINDOW_WIDTH, WINDOW_HEIGHT)
    @texture = SDL2.CreateTexture @renderer, SDL2::PIXELFORMAT_ARGB8888, 1, SCREEN_WIDTH, SCREEN_HEIGHT
    @last = Process.clock_gettime(Process::CLOCK_MONOTONIC)

    @titles = (0..200).map {|n| "GBRuby (%d fps)" % n }

    @frames_counter = 0
    @total_fps = 0
    @frames_limit = -1
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

    @total_fps += fps

    fps = fps.floor
    @last = t

    @frames_counter += 1

    @buffer.write_array_of_uint32 framebuffer
    SDL2.UpdateTexture @texture, nil, @buffer, SCREEN_WIDTH * 4
    SDL2.RenderClear @renderer
    SDL2.RenderCopy @renderer, @texture, nil, nil
    SDL2.RenderPresent @renderer

    fps = 200 if fps > 200
    SDL2.SetWindowTitle(@window, @titles[fps])

    exit if @frames_counter == @frames_limit
  end

  def avg_fps
    @total_fps / @frames_counter
  end
end
