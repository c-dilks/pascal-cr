require "big"
require "celestine"
require "./colors"

module Pascal

  # store one row of the pascal triangle
  class Row
    getter nums, mods
    property drawSize, palette, rowNumMax

    def initialize(
      @rowNumMax : Int128,                    # maximum number of rows
      @nums : Array(BigInt) = [BigInt.new 1], # initial row elements
      @beginRow : Int128 = 0,                 # initial row number
    )
      @mods     = @nums
      @rowNum   = 0
      @drawSize = 1.0
      @palette  = Colors::Palette.new
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

  end # Pascal::Row

end # Pascal
