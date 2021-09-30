class PPU
  # screen 160 x 144

  # Mode 00: When the flag is 00 it is the H-Blank
  # period and the CPU can access the display
  # RAM ($8000-$9FFF).
  # Mode 01: When the flag is 01 it is the V-Blank
  # period and the CPU can access the display
  # RAM ($8000-$9FFF).
  # Mode 10: When the flag is 10 then the OAM is being
  # used ($FE00-$FE9F). The CPU cannot access
  # the OAM during this period
  # Mode 11: When the flag is 11 both the OAM and
  # display RAM are being used. The CPU cannot
  # access either during this period.

  # The Mode Flag goes through the values 0, 2,
  # and 3 at a cycle of about 109uS. 0 is present
  # about 48.6uS, 2 about 19uS, and 3 about 41uS.
  # This is interrupted every 16.6ms by the VBlank
  # (1). The mode flag stays set at 1 for about 1.08
  # ms. (Mode 0 is present between 201-207 clks, 2
  # about 77-83 clks, and 3 about 169-175 clks. A
  # complete cycle through these states takes 456
  # clks. VBlank lasts 4560 clks. A complete screen
  # refresh occurs every 70224 clks.)

  # The screen resolution is 160x144 meaning there are 144 visible scanlines.
  # The Gameboy draws each scanline one at a time starting from 0 to 153,
  # this means there are 144 visible scanlines and 8 invisible scanlines.
  # When the current scanline is between 144 and 153 this is the vertical blank period.
  # The current scanline is stored in register address 0xFF44.
  # The pandocs tell us that it takes 456 cpu clock cycles to draw one scanline

  # Complete refresh: 456 for a scanline
  # Every: 70_224

  # 456 * 144 = 65664 + 4560 = 70224

  # Clock: 4_194_304

  # 4_194_304 / 70_224 = 59.7275

  # Period	                    GPU mode number	    Time spent (clocks)
  # Scanline (accessing OAM)	        2	                  80
  # Scanline (accessing VRAM)	        3	                  172
  # Horizontal blank	                0	                  204
  # One line (scan and blank)		                          456
  # Vertical blank	                  1	                  4560 (10 lines)
  # Full frame (scans and vblank)		                      70224

  # STAT shows the current status of the LCD controller.
  STAT = 0x41

  # The LY indicates the vertical line to which the present data is transferred to the LCD
  # Driver. The LY can take on any value between 0 through 153. The values between
  # 144 and 153 indicate the V-Blank period. Writing will reset the counter.
  LY  = 0x44

  # The LYC compares itself with the LY.
  # If the values are the same it causes the STAT to set the coincident flag.
  LYC = 0x45

  MODE_MASK = 0b11111100
  MODE_0 = 0 # During H-Blank
  MODE_1 = 1 # During V-Blank
  MODE_2 = 2 # During Searching OAM-RAM
  MODE_3 = 3 # During Transfering Data to LCD Driver

  def set_mode(mode)

  end

  def set_io(address, value)
    @device.write_byte(0xFF00 + address, value)
  end

  def initialize(device)
    @device = device
    @scan_line = 0
    @cycle = 0
    # TODO
  end

  def step(cycles)
    @cycles = cycles
    @scan_line = @cycles / 456
    set_io(LY, @scan_line)

    # TODO
  end
end
