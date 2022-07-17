module Colors

  class Palette
    property colormap

    def initialize
      @gradient = Hash(String,Array(String)).new
      @colormap = Array(String).new
      @numMin = 0
      @numMax = 1

      # linear interpolated gradients
      @gradient["grayscale"] = self.lerp [0x00,0x00,0x00], [0xFF,0xFF,0xFF]
      @gradient["red"]       = self.lerp [0x00,0x00,0x00], [0xFF,0x00,0x00]
      @gradient["green"]     = self.lerp [0x00,0x00,0x00], [0x00,0xFF,0x00]
      @gradient["blue"]      = self.lerp [0x00,0x00,0x00], [0x00,0x00,0xFF]
      @gradient["cyan"]      = self.lerp [0x00,0x00,0x00], [0x00,0xFF,0xFF]
      @gradient["magenta"]   = self.lerp [0x00,0x00,0x00], [0xFF,0x00,0xFF]
      @gradient["yellow"]    = self.lerp [0x00,0x00,0x00], [0xFF,0xFF,0x00]

      # generated from https://colordesigner.io/gradient-generator
      @gradient["greenblue"] = [
        "#fafa6e", "#edf76f", "#e0f470", "#d4f171", "#c8ed73",
        "#bcea75", "#b0e678", "#a5e27a", "#99de7c", "#8eda7f",
        "#83d681", "#79d283", "#6ecd85", "#64c987", "#5ac489",
        "#50bf8b", "#46bb8c", "#3cb68d", "#32b18e", "#28ac8f",
        "#1ea78f", "#12a28f", "#039d8f", "#00988e", "#00938d",
        "#008e8c", "#00898a", "#008488", "#007e86", "#007983",
        "#057480", "#0e6f7d", "#156a79", "#1a6575", "#1e6071",
        "#225b6c", "#255667", "#275163", "#294d5d", "#2a4858",
      ]

      # obtained from https://github.com/sausheong/thermalcam/blob/master/heatmap.go
      @gradient["heatmap"] = [
        "#0000ff", "#0001ff", "#0002ff", "#0003ff", "#0004ff", "#0005ff", "#0006ff", "#0007ff",
        "#0008ff", "#0009ff", "#000aff", "#000bff", "#000cff", "#000dff", "#000eff", "#000fff",
        "#0010ff", "#0011ff", "#0012ff", "#0013ff", "#0014ff", "#0015ff", "#0016ff", "#0017ff",
        "#0018ff", "#0019ff", "#001aff", "#001bff", "#001cff", "#001dff", "#001eff", "#001fff",
        "#0020ff", "#0021ff", "#0022ff", "#0023ff", "#0024ff", "#0025ff", "#0026ff", "#0027ff",
        "#0028ff", "#0029ff", "#002aff", "#002bff", "#002cff", "#002dff", "#002eff", "#002fff",
        "#0030ff", "#0031ff", "#0032ff", "#0033ff", "#0034ff", "#0035ff", "#0036ff", "#0037ff",
        "#0038ff", "#0039ff", "#003aff", "#003bff", "#003cff", "#003dff", "#003eff", "#003fff",
        "#0040ff", "#0041ff", "#0042ff", "#0043ff", "#0044ff", "#0045ff", "#0046ff", "#0047ff",
        "#0048ff", "#0049ff", "#004aff", "#004bff", "#004cff", "#004dff", "#004eff", "#004fff",
        "#0050ff", "#0051ff", "#0052ff", "#0053ff", "#0054ff", "#0055ff", "#0056ff", "#0057ff",
        "#0058ff", "#0059ff", "#005aff", "#005bff", "#005cff", "#005dff", "#005eff", "#005fff",
        "#0060ff", "#0061ff", "#0062ff", "#0063ff", "#0064ff", "#0065ff", "#0066ff", "#0067ff",
        "#0068ff", "#0069ff", "#006aff", "#006bff", "#006cff", "#006dff", "#006eff", "#006fff",
        "#0070ff", "#0071ff", "#0072ff", "#0073ff", "#0074ff", "#0075ff", "#0076ff", "#0077ff",
        "#0078ff", "#0079ff", "#007aff", "#007bff", "#007cff", "#007dff", "#007eff", "#007fff",
        "#0080ff", "#0081ff", "#0082ff", "#0083ff", "#0084ff", "#0085ff", "#0086ff", "#0087ff",
        "#0088ff", "#0089ff", "#008aff", "#008bff", "#008cff", "#008dff", "#008eff", "#008fff",
        "#0090ff", "#0091ff", "#0092ff", "#0093ff", "#0094ff", "#0095ff", "#0096ff", "#0097ff",
        "#0098ff", "#0099ff", "#009aff", "#009bff", "#009cff", "#009dff", "#009eff", "#009fff",
        "#00a0ff", "#00a1ff", "#00a2ff", "#00a3ff", "#00a4ff", "#00a5ff", "#00a6ff", "#00a7ff",
        "#00a8ff", "#00a9ff", "#00aaff", "#00aaff", "#00abff", "#00acff", "#00adff", "#00aeff",
        "#00afff", "#00b0ff", "#00b1ff", "#00b2ff", "#00b3ff", "#00b4ff", "#00b5ff", "#00b6ff",
        "#00b7ff", "#00b8ff", "#00b9ff", "#00baff", "#00bbff", "#00bcff", "#00bdff", "#00beff",
        "#00bfff", "#00c0ff", "#00c1ff", "#00c2ff", "#00c3ff", "#00c4ff", "#00c5ff", "#00c6ff",
        "#00c7ff", "#00c8ff", "#00c9ff", "#00caff", "#00cbff", "#00ccff", "#00cdff", "#00ceff",
        "#00cfff", "#00d0ff", "#00d1ff", "#00d2ff", "#00d3ff", "#00d4ff", "#00d5ff", "#00d6ff",
        "#00d7ff", "#00d8ff", "#00d9ff", "#00daff", "#00dbff", "#00dcff", "#00ddff", "#00deff",
        "#00dfff", "#00e0ff", "#00e1ff", "#00e2ff", "#00e3ff", "#00e4ff", "#00e5ff", "#00e6ff",
        "#00e7ff", "#00e8ff", "#00e9ff", "#00eaff", "#00ebff", "#00ecff", "#00edff", "#00eeff",
        "#00efff", "#00f0ff", "#00f1ff", "#00f2ff", "#00f3ff", "#00f4ff", "#00f5ff", "#00f6ff",
        "#00f7ff", "#00f8ff", "#00f9ff", "#00faff", "#00fbff", "#00fcff", "#00fdff", "#00feff",
        "#00ffff", "#00fffe", "#00fffd", "#00fffc", "#00fffb", "#00fffa", "#00fff9", "#00fff8",
        "#00fff7", "#00fff6", "#00fff5", "#00fff4", "#00fff3", "#00fff2", "#00fff1", "#00fff0",
        "#00ffef", "#00ffee", "#00ffed", "#00ffec", "#00ffeb", "#00ffea", "#00ffe9", "#00ffe8",
        "#00ffe7", "#00ffe6", "#00ffe5", "#00ffe4", "#00ffe3", "#00ffe2", "#00ffe1", "#00ffe0",
        "#00ffdf", "#00ffde", "#00ffdd", "#00ffdc", "#00ffdb", "#00ffda", "#00ffd9", "#00ffd8",
        "#00ffd7", "#00ffd6", "#00ffd5", "#00ffd4", "#00ffd3", "#00ffd2", "#00ffd1", "#00ffd0",
        "#00ffcf", "#00ffce", "#00ffcd", "#00ffcc", "#00ffcb", "#00ffca", "#00ffc9", "#00ffc8",
        "#00ffc7", "#00ffc6", "#00ffc5", "#00ffc4", "#00ffc3", "#00ffc2", "#00ffc1", "#00ffc0",
        "#00ffbf", "#00ffbe", "#00ffbd", "#00ffbc", "#00ffbb", "#00ffba", "#00ffb9", "#00ffb8",
        "#00ffb7", "#00ffb6", "#00ffb5", "#00ffb4", "#00ffb3", "#00ffb2", "#00ffb1", "#00ffb0",
        "#00ffaf", "#00ffae", "#00ffad", "#00ffac", "#00ffab", "#00ffaa", "#00ffa9", "#00ffa8",
        "#00ffa7", "#00ffa6", "#00ffa5", "#00ffa4", "#00ffa3", "#00ffa2", "#00ffa1", "#00ffa0",
        "#00ff9f", "#00ff9e", "#00ff9d", "#00ff9c", "#00ff9b", "#00ff9a", "#00ff99", "#00ff98",
        "#00ff97", "#00ff96", "#00ff95", "#00ff94", "#00ff93", "#00ff92", "#00ff91", "#00ff90",
        "#00ff8f", "#00ff8e", "#00ff8d", "#00ff8c", "#00ff8b", "#00ff8a", "#00ff89", "#00ff88",
        "#00ff87", "#00ff86", "#00ff85", "#00ff84", "#00ff83", "#00ff82", "#00ff81", "#00ff80",
        "#00ff7f", "#00ff7e", "#00ff7d", "#00ff7c", "#00ff7b", "#00ff7a", "#00ff79", "#00ff78",
        "#00ff77", "#00ff76", "#00ff75", "#00ff74", "#00ff73", "#00ff72", "#00ff71", "#00ff70",
        "#00ff6f", "#00ff6e", "#00ff6d", "#00ff6c", "#00ff6b", "#00ff6a", "#00ff69", "#00ff68",
        "#00ff67", "#00ff66", "#00ff65", "#00ff64", "#00ff63", "#00ff62", "#00ff61", "#00ff60",
        "#00ff5f", "#00ff5e", "#00ff5d", "#00ff5c", "#00ff5b", "#00ff5a", "#00ff59", "#00ff58",
        "#00ff57", "#00ff56", "#00ff55", "#00ff54", "#00ff53", "#00ff52", "#00ff51", "#00ff50",
        "#00ff4f", "#00ff4e", "#00ff4d", "#00ff4c", "#00ff4b", "#00ff4a", "#00ff49", "#00ff48",
        "#00ff47", "#00ff46", "#00ff45", "#00ff44", "#00ff43", "#00ff42", "#00ff41", "#00ff40",
        "#00ff3f", "#00ff3e", "#00ff3d", "#00ff3c", "#00ff3b", "#00ff3a", "#00ff39", "#00ff38",
        "#00ff37", "#00ff36", "#00ff35", "#00ff34", "#00ff33", "#00ff32", "#00ff31", "#00ff30",
        "#00ff2f", "#00ff2e", "#00ff2d", "#00ff2c", "#00ff2b", "#00ff2a", "#00ff29", "#00ff28",
        "#00ff27", "#00ff26", "#00ff25", "#00ff24", "#00ff23", "#00ff22", "#00ff21", "#00ff20",
        "#00ff1f", "#00ff1e", "#00ff1d", "#00ff1c", "#00ff1b", "#00ff1a", "#00ff19", "#00ff18",
        "#00ff17", "#00ff16", "#00ff15", "#00ff14", "#00ff13", "#00ff12", "#00ff11", "#00ff10",
        "#00ff0f", "#00ff0e", "#00ff0d", "#00ff0c", "#00ff0b", "#00ff0a", "#00ff09", "#00ff08",
        "#00ff07", "#00ff06", "#00ff05", "#00ff04", "#00ff03", "#00ff02", "#00ff01", "#00ff00",
        "#00ff00", "#01ff00", "#02ff00", "#03ff00", "#04ff00", "#05ff00", "#06ff00", "#07ff00",
        "#08ff00", "#09ff00", "#0aff00", "#0bff00", "#0cff00", "#0dff00", "#0eff00", "#0fff00",
        "#10ff00", "#11ff00", "#12ff00", "#13ff00", "#14ff00", "#15ff00", "#16ff00", "#17ff00",
        "#18ff00", "#19ff00", "#1aff00", "#1bff00", "#1cff00", "#1dff00", "#1eff00", "#1fff00",
        "#20ff00", "#21ff00", "#22ff00", "#23ff00", "#24ff00", "#25ff00", "#26ff00", "#27ff00",
        "#28ff00", "#29ff00", "#2aff00", "#2bff00", "#2cff00", "#2dff00", "#2eff00", "#2fff00",
        "#30ff00", "#31ff00", "#32ff00", "#33ff00", "#34ff00", "#35ff00", "#36ff00", "#37ff00",
        "#38ff00", "#39ff00", "#3aff00", "#3bff00", "#3cff00", "#3dff00", "#3eff00", "#3fff00",
        "#40ff00", "#41ff00", "#42ff00", "#43ff00", "#44ff00", "#45ff00", "#46ff00", "#47ff00",
        "#48ff00", "#49ff00", "#4aff00", "#4bff00", "#4cff00", "#4dff00", "#4eff00", "#4fff00",
        "#50ff00", "#51ff00", "#52ff00", "#53ff00", "#54ff00", "#55ff00", "#56ff00", "#57ff00",
        "#58ff00", "#59ff00", "#5aff00", "#5bff00", "#5cff00", "#5dff00", "#5eff00", "#5fff00",
        "#60ff00", "#61ff00", "#62ff00", "#63ff00", "#64ff00", "#65ff00", "#66ff00", "#67ff00",
        "#68ff00", "#69ff00", "#6aff00", "#6bff00", "#6cff00", "#6dff00", "#6eff00", "#6fff00",
        "#70ff00", "#71ff00", "#72ff00", "#73ff00", "#74ff00", "#75ff00", "#76ff00", "#77ff00",
        "#78ff00", "#79ff00", "#7aff00", "#7bff00", "#7cff00", "#7dff00", "#7eff00", "#7fff00",
        "#80ff00", "#81ff00", "#82ff00", "#83ff00", "#84ff00", "#85ff00", "#86ff00", "#87ff00",
        "#88ff00", "#89ff00", "#8aff00", "#8bff00", "#8cff00", "#8dff00", "#8eff00", "#8fff00",
        "#90ff00", "#91ff00", "#92ff00", "#93ff00", "#94ff00", "#95ff00", "#96ff00", "#97ff00",
        "#98ff00", "#99ff00", "#9aff00", "#9bff00", "#9cff00", "#9dff00", "#9eff00", "#9fff00",
        "#a0ff00", "#a1ff00", "#a2ff00", "#a3ff00", "#a4ff00", "#a5ff00", "#a6ff00", "#a7ff00",
        "#a8ff00", "#a9ff00", "#aaff00", "#abff00", "#acff00", "#adff00", "#aeff00", "#afff00",
        "#b0ff00", "#b1ff00", "#b2ff00", "#b3ff00", "#b4ff00", "#b5ff00", "#b6ff00", "#b7ff00",
        "#b8ff00", "#b9ff00", "#baff00", "#bbff00", "#bcff00", "#bdff00", "#beff00", "#bfff00",
        "#c0ff00", "#c1ff00", "#c2ff00", "#c3ff00", "#c4ff00", "#c5ff00", "#c6ff00", "#c7ff00",
        "#c8ff00", "#c9ff00", "#caff00", "#cbff00", "#ccff00", "#cdff00", "#ceff00", "#cfff00",
        "#d0ff00", "#d1ff00", "#d2ff00", "#d3ff00", "#d4ff00", "#d5ff00", "#d6ff00", "#d7ff00",
        "#d8ff00", "#d9ff00", "#daff00", "#dbff00", "#dcff00", "#ddff00", "#deff00", "#dfff00",
        "#e0ff00", "#e1ff00", "#e2ff00", "#e3ff00", "#e4ff00", "#e5ff00", "#e6ff00", "#e7ff00",
        "#e8ff00", "#e9ff00", "#eaff00", "#ebff00", "#ecff00", "#edff00", "#eeff00", "#efff00",
        "#f0ff00", "#f1ff00", "#f2ff00", "#f3ff00", "#f4ff00", "#f5ff00", "#f6ff00", "#f7ff00",
        "#f8ff00", "#f9ff00", "#faff00", "#fbff00", "#fcff00", "#fdff00", "#feff00", "#ffff00",
        "#fffe00", "#fffd00", "#fffc00", "#fffb00", "#fffa00", "#fff900", "#fff800", "#fff700",
        "#fff600", "#fff500", "#fff400", "#fff300", "#fff200", "#fff100", "#fff000", "#ffef00",
        "#ffee00", "#ffed00", "#ffec00", "#ffeb00", "#ffea00", "#ffe900", "#ffe800", "#ffe700",
        "#ffe600", "#ffe500", "#ffe400", "#ffe300", "#ffe200", "#ffe100", "#ffe000", "#ffdf00",
        "#ffde00", "#ffdd00", "#ffdc00", "#ffdb00", "#ffda00", "#ffd900", "#ffd800", "#ffd700",
        "#ffd600", "#ffd500", "#ffd400", "#ffd300", "#ffd200", "#ffd100", "#ffd000", "#ffcf00",
        "#ffce00", "#ffcd00", "#ffcc00", "#ffcb00", "#ffca00", "#ffc900", "#ffc800", "#ffc700",
        "#ffc600", "#ffc500", "#ffc400", "#ffc300", "#ffc200", "#ffc100", "#ffc000", "#ffbf00",
        "#ffbe00", "#ffbd00", "#ffbc00", "#ffbb00", "#ffba00", "#ffb900", "#ffb800", "#ffb700",
        "#ffb600", "#ffb500", "#ffb400", "#ffb300", "#ffb200", "#ffb100", "#ffb000", "#ffaf00",
        "#ffae00", "#ffad00", "#ffac00", "#ffab00", "#ffaa00", "#ffaa00", "#ffa900", "#ffa800",
        "#ffa700", "#ffa600", "#ffa500", "#ffa400", "#ffa300", "#ffa200", "#ffa100", "#ffa000",
        "#ff9f00", "#ff9e00", "#ff9d00", "#ff9c00", "#ff9b00", "#ff9a00", "#ff9900", "#ff9800",
        "#ff9700", "#ff9600", "#ff9500", "#ff9400", "#ff9300", "#ff9200", "#ff9100", "#ff9000",
        "#ff8f00", "#ff8e00", "#ff8d00", "#ff8c00", "#ff8b00", "#ff8a00", "#ff8900", "#ff8800",
        "#ff8700", "#ff8600", "#ff8500", "#ff8400", "#ff8300", "#ff8200", "#ff8100", "#ff8000",
        "#ff7f00", "#ff7e00", "#ff7d00", "#ff7c00", "#ff7b00", "#ff7a00", "#ff7900", "#ff7800",
        "#ff7700", "#ff7600", "#ff7500", "#ff7400", "#ff7300", "#ff7200", "#ff7100", "#ff7000",
        "#ff6f00", "#ff6e00", "#ff6d00", "#ff6c00", "#ff6b00", "#ff6a00", "#ff6900", "#ff6800",
        "#ff6700", "#ff6600", "#ff6500", "#ff6400", "#ff6300", "#ff6200", "#ff6100", "#ff6000",
        "#ff5f00", "#ff5e00", "#ff5d00", "#ff5c00", "#ff5b00", "#ff5a00", "#ff5900", "#ff5800",
        "#ff5700", "#ff5600", "#ff5500", "#ff5400", "#ff5300", "#ff5200", "#ff5100", "#ff5000",
        "#ff4f00", "#ff4e00", "#ff4d00", "#ff4c00", "#ff4b00", "#ff4a00", "#ff4900", "#ff4800",
        "#ff4700", "#ff4600", "#ff4500", "#ff4400", "#ff4300", "#ff4200", "#ff4100", "#ff4000",
        "#ff3f00", "#ff3e00", "#ff3d00", "#ff3c00", "#ff3b00", "#ff3a00", "#ff3900", "#ff3800",
        "#ff3700", "#ff3600", "#ff3500", "#ff3400", "#ff3300", "#ff3200", "#ff3100", "#ff3000",
        "#ff2f00", "#ff2e00", "#ff2d00", "#ff2c00", "#ff2b00", "#ff2a00", "#ff2900", "#ff2800",
        "#ff2700", "#ff2600", "#ff2500", "#ff2400", "#ff2300", "#ff2200", "#ff2100", "#ff2000",
        "#ff1f00", "#ff1e00", "#ff1d00", "#ff1c00", "#ff1b00", "#ff1a00", "#ff1900", "#ff1800",
        "#ff1700", "#ff1600", "#ff1500", "#ff1400", "#ff1300", "#ff1200", "#ff1100", "#ff1000",
        "#ff0f00", "#ff0e00", "#ff0d00", "#ff0c00", "#ff0b00", "#ff0a00", "#ff0900", "#ff0800",
        "#ff0700", "#ff0600", "#ff0500", "#ff0400", "#ff0300", "#ff0200", "#ff0100", "#ff0000",
      ]

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
    def lerp( color1=[0x00,0x00,0x00], color2=[0xFF,0xFF,0xFF], size=100)
      size.times.map do |i|
        frac = i.to_f / size.to_f
        colorLerp = color1.zip(color2).map do |c1,c2|
          ( c1+(c2-c1)*frac ).to_i
        end
        colorI = colorLerp[2] + (colorLerp[1]<<8) + (colorLerp[0]<<16)
        colorHex = colorI.to_s(16)
        (6-colorHex.size).times do colorHex="0"+colorHex end
        # colors << "#"+colorHex
        "#"+colorHex
      end.to_a
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
