module Colors

  class Palette
    property colormap

    def initialize
      @gradient = Hash(String,Array(String)).new
      @colormap = Array(String).new
      @numMin = 0
      @numMax = 1

      # linearly interpolated gradients
      @gradient["grayscale"] = self.lerp 0x000000, 0xFFFFFF
      @gradient["red"]       = self.lerp 0x000000, 0xFF0000
      @gradient["green"]     = self.lerp 0x000000, 0x00FF00
      @gradient["blue"]      = self.lerp 0x000000, 0x0000FF
      @gradient["cyan"]      = self.lerp 0x000000, 0x00FFFF
      @gradient["magenta"]   = self.lerp 0x000000, 0xFF00FF
      @gradient["yellow"]    = self.lerp 0x000000, 0xFFFF00

      @gradient["warm"]      = self.lerp_sequence [ 0x702A8C, 0xBF2669, 0xFF194D, 0xFF7326, 0xFFCC0D ]
      @gradient["lava"]      = self.lerp_sequence [ 0x1E1E20, 0x2A2C2B, 0x374140, 0xD9CB9E, 0xDC3522 ]
      @gradient["water"]     = self.lerp_sequence [ 0x1E1E20, 0x2A2C2B, 0x374140, 0xD9CB9E, 0x22ACDC ]
      @gradient["rainbow"]   = self.lerp_sequence [ 0xFA233E, 0xFFA15C, 0xF5EB67, 0x44D492, 0x88F7E2 ]

      # default
      @colormap = @gradient["grayscale"]

    end # initialize


    ###################################################
    # configuration

    # set the colormap
    def set_gradient(key)
      begin
        if key=~/-rev$/
          @colormap = @gradient[key.sub(/-rev$/,"")].reverse
        else
          @colormap = @gradient[key]
        end
      rescue
        STDERR.puts "ERROR: cannot find gradient #{key}"
      end
      # puts "GRADIENT"
      # p! @colormap
    end

    # set the range, for `self.colorize`
    def set_range(min,max)
      @numMin = min
      @numMax = max
    end

    # return String listing all available colormaps
    def help
      str = ""
      append = ->(list : Array(String)) {
        indent = " "*8
        list.each{ |item| str += "#{indent}#{item}, #{item}-rev\n" }
      }
      append.call @gradient.keys
      str
    end


    ###################################################
    # interpolation

    # generate a gradient array using linear interpolation
    def lerp( color1=0x000000, color2=0xFFFFFF, size=256 )
      decode = ->(hex : Int32) {
        [
          (hex & 0xFF0000) >> 16,
          (hex & 0xFF00)   >> 8,
          hex & 0xFF
        ]
      }
      color1rgb = decode.call color1
      color2rgb = decode.call color2
      size.times.map do |i|
        frac = i.to_f / size.to_f
        colorLerp = color1rgb.zip(color2rgb).map do |c1,c2|
          ( c1+(c2-c1)*frac ).to_i
        end
        colorI = colorLerp[2] + (colorLerp[1]<<8) + (colorLerp[0]<<16)
        colorHex = colorI.to_s(16)
        (6-colorHex.size).times do colorHex="0"+colorHex end
        "#"+colorHex
      end.to_a
    end

    # run `lerp` multiple times to generate a full palette
    def lerp_sequence( colors=[0x000000,0xFFFFFF], size=256 )
      sequence = Array(String).new
      colors[0..-2].each_with_index do |color,i|
        sequence += self.lerp color, colors[i+1], size
      end
      sequence.uniq
    end

    # return hex color string, from `@colormap` given a number `num`
    def colorize(num)
      frac = (num-@numMin)/(@numMax-@numMin)
      max = @colormap.size-1
      idx = (frac*max).to_i
      unless (0..max)===idx
        STDERR.puts "WARNING: colorize saturated"
        p! num,@numMin,@numMax,frac,idx
        idx = idx<0 ? 0 : max
      end
      # p! "",num,frac,idx # debug
      @colormap[idx]
    end

  end # class Palette
end # module Colors
