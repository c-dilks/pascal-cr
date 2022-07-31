require "./generator"

module Mathographix

  # store one row of the pascal triangle
  class Pascal < Generator
    getter nums, mods
    property rowNumMax, mod_function_update_mode

    def initialize(
      @rowNumMax : Int128,                    # maximum number of rows
      @nums : Array(BigInt) = [BigInt.new 1], # initial row elements
      @beginRow : Int128 = 0,                 # initial row number
    )
      @mods   = @nums
      @rowNum = 0
      @mod_function_update_mode = "none"
      super()
    end

    # compute the next row of the triangle
    def next
      @nums = ([0]+@nums).zip(@nums+[0]).map &.sum
      @rowNum += 1
    end

    # run a calculation on a row's `@nums`, store results in `@mods`
    def modify
      @mod_function = self.mod_function_update
      @mods = super @nums
    end

    # update a modifier function
    def mod_function_update
      case @mod_function_update_mode
      when "modulo_row"
        @mod_function = modulo(@rowNum+1)
      end
      @mod_function
    end

    # text output
    def output(stream=STDOUT)
      stream.puts @nums
      # stream.puts @mods
    end

    # svg output
    def draw(ctx)
      @mods.each_with_index do |num,colNum|
        ctx.rectangle do |rec|
          offset     = ( @rowNumMax - @rowNum + @beginRow ) / 2
          rec.x      = ( offset + colNum ) * @drawSize
          rec.y      = ( @rowNum - @beginRow) * @drawSize
          rec.width  = @drawSize
          rec.height = @drawSize
          rec.fill   = @palette.colorize num
          rec
        end
      end
    end

  end
end
