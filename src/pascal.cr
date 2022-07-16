require "big"

module Pascal

  # store one row of the pascal triangle
  class Row
    getter nums, mods

    def initialize(@nums : Array(BigInt) = [BigInt.new 1])
      @mods = @nums
    end

    # compute the next row of the triangle
    def next
      @nums = ([0]+@nums).zip(@nums+[0]).map &.sum
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

    # output method sandbox
    def output(stream=STDOUT)
      stream = STDOUT # force stdout
      stream.puts @nums
      # stream.puts @mods
    end

  end

end
