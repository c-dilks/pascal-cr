require "big"
require "celestine"

module Pascal

  # store one row of the pascal triangle
  class Row
    getter nums, mods
    property drawSize

    def initialize(
      @nums : Array(BigInt) = [BigInt.new 1], # initial row
    )
      @mods     = @nums
      @rowNum   = 0
      @drawSize = 1.0
    end

    # compute the next row of the triangle
    def next
      @nums = ([0]+@nums).zip(@nums+[0]).map &.sum
      @rowNum += 1
    end

    # run a calculation on a row's `@nums`;
    # the result is stored in `@mods`
    def modify
      @mods = @nums.map do |num| yield num end
    end

    # set `@mods` to be `@nums modulo m`
    def modulo(m)
      self.modify do |num| num.modulo m end
    end

    # text output
    def output(stream=STDOUT)
      stream.puts @nums
      # stream.puts @mods
    end

    # color interpolator
    def colorize(num)
      # color1 = [ 0,   0,   0   ]
      # color2 = [ 255, 255, 255 ]
      color1 = [ 10, 0,   0   ]
      color2 = [ 0,  255, 255 ]
      colorLerp = color1.zip(color2).map do |c1,c2|
        c = c1+(c2-c1)*num
        c.to_i
      end
      colorI = colorLerp[2] + (colorLerp[1]<<8) + (colorLerp[0]<<16)
      colorHex = colorI.to_s(16)
      (6-colorHex.size).times do colorHex="0"+colorHex end
      colorHex = "#"+colorHex
      # puts "#{num} to #{colorHex}"
      colorHex
    end

    # svg output
    def draw(ctx,rowNumMax,numMin,numMax)
      @mods.each_with_index do |num,colNum|
        ctx.rectangle do |rec|
          offset     = ( rowNumMax - @rowNum ) / 2
          rec.x      = ( offset + colNum ) * @drawSize
          rec.y      = @rowNum * @drawSize
          rec.width  = @drawSize
          rec.height = @drawSize
          rec.fill   = self.colorize (num-numMin)/(numMax-numMin)
          rec
        end
      end
    end

  end # Pascal::Row

end # Pascal
