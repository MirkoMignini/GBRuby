require 'ffi'

module SDL2
  extend FFI::Library
  ffi_lib "SDL2"

  WINDOW_FULLSCREEN         = 0x00000001
  WINDOW_OPENGL             = 0x00000002
  WINDOW_SHOWN              = 0x00000004
  WINDOW_HIDDEN             = 0x00000008
  WINDOW_BORDERLESS         = 0x00000010
  WINDOW_RESIZABLE          = 0x00000020
  WINDOW_MINIMIZED          = 0x00000040
  WINDOW_MAXIMIZED          = 0x00000080
  WINDOW_INPUT_GRABBED      = 0x00000100
  WINDOW_INPUT_FOCUS        = 0x00000200
  WINDOW_MOUSE_FOCUS        = 0x00000400
  WINDOW_FULLSCREEN_DESKTOP = (WINDOW_FULLSCREEN | 0x00001000)

  PIXELFORMAT_ARGB8888 = 0x16362004

  attach_function :CreateRenderer, 'SDL_CreateRenderer', [:pointer, :int, :uint32], :pointer
  attach_function :CreateTexture, 'SDL_CreateTexture', [:pointer, :uint32, :int, :int, :int], :pointer
  attach_function :CreateWindow, 'SDL_CreateWindow', [ :string, :int, :int, :int, :int, :uint32 ], :pointer
  attach_function :DestroyRenderer, 'SDL_DestroyRenderer', [:pointer], :void
  attach_function :DestroyTexture, 'SDL_DestroyTexture', [:pointer], :void
  attach_function :DestroyWindow, 'SDL_DestroyWindow', [:pointer], :void
  attach_function :GetKeyboardState, 'SDL_GetKeyboardState', [:pointer], :pointer
  attach_function :InitSubSystem, 'SDL_InitSubSystem', [ :uint32 ], :int
  attach_function :PollEvent, 'SDL_PollEvent', [:pointer], :int
  attach_function :QuitSubSystem, 'SDL_QuitSubSystem', [:uint32], :void, { blocking: true }
  attach_function :RenderClear, 'SDL_RenderClear', [:pointer], :int
  attach_function :RenderCopy, 'SDL_RenderCopy', [:pointer, :pointer, :pointer, :pointer], :int
  attach_function :RenderPresent, 'SDL_RenderPresent', [:pointer], :int
  attach_function :RenderSetLogicalSize, 'SDL_RenderSetLogicalSize', [:pointer, :int, :int], :int
  attach_function :SetHint, 'SDL_SetHint', [:string, :string], :int
  attach_function :SetWindowTitle, 'SDL_SetWindowTitle', [:pointer, :string], :void
  attach_function :UpdateTexture, 'SDL_UpdateTexture', [:pointer, :pointer, :pointer, :int], :int
end
