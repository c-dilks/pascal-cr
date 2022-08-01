require "./generator"

module Mathographix

  # store one row of the pascal triangle
  class Pascal < Generator
    getter nums, mods
    property mod_function_update_mode
    @@subcommand = "pascal"
    @@description = "Pasal Triangle"

    def initialize
      super()
      # defaults
      @size   = Int128.new 17*17
      @nums   = [ BigInt.new 1 ]
      @mods   = @nums
      @rowNum = 0
      # modifiers
      @mod_function_update_mode = "none"
      @mod_functions += ["modulo-row"]
      # options
      @options += [
        Options::GeneratorOption.new(
          "-n NUM_ROWS",
          "--num NUM_ROWS",
          "number of rows to generate",
          Options::OptionProc.new { |s| @size = s.to_i128 }
        ),
        Options::GeneratorOption.new(
          "-b BEGINROW",
          "--begin-row BEGINROW",
          "row number to begin output on",
          Options::OptionProc.new { |s| @first_iter = s.to_i128 }
        ),
        Options::GeneratorOption.new(
          "-s SEED",
          "--seed SEED",
          "seed row number(s), e.g., `-s 1,2,3`",
          Options::OptionProc.new { |s| @nums = s.split(',').map{ |n| BigInt.new n } }
        ),
      ]
    end

    def print_settings
      puts "#{@@subcommand} generator settings".upcase
      super
      p! @nums
    end

    #################################################

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

    #################################################

    # text output
    def output(stream=STDOUT)
      stream.puts @nums
      # stream.puts @mods
    end

    # svg output
    def draw(ctx)
      @mods.each_with_index do |num,colNum|
        ctx.rectangle do |rec|
          offset     = ( @size - @rowNum + @first_iter ) / 2
          rec.x      = ( offset + colNum ) * @drawSize
          rec.y      = ( @rowNum - @first_iter) * @drawSize
          rec.width  = @drawSize
          rec.height = @drawSize
          rec.fill   = @palette.colorize num
          rec
        end
      end
    end

  end
end
