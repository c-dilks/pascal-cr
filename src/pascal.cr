require "big"
require "celestine"

module Pascal

  # store one row of the pascal triangle
  class Row
    getter nums, mods
    DRAW_SIZE = 1

    def initialize(
      @nums : Array(BigInt) = [BigInt.new 1], # initial row
    )
      @mods   = @nums
      @rowNum = 0
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
    def draw(ctx,rowNumMax)
      @mods.each_with_index do |num,colNum|
        ctx.rectangle do |rec|
          offset     = ( rowNumMax - @rowNum ) / 2
          rec.x      = ( offset + colNum ) * DRAW_SIZE
          rec.y      = @rowNum * DRAW_SIZE
          rec.width  = DRAW_SIZE
          rec.height = DRAW_SIZE
          rec.fill   = "##{num}#{num}#{num}"
          rec
        end
      end
    end

    # macros
    def_clone

  end # Pascal::Row

end # Pascal
