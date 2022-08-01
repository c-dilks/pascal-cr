require "big"
require "celestine"
require "../colors"
require "../options"

module Mathographix

  alias ModProc = BigInt -> BigInt

  # base class for generators
  class Generator
    property size, first_iter, drawSize, palette, mod_function, mod_functions, options
    @size         : Int128
    @first_iter   : Int128
    @mod_function : ModProc

    # class variables
    @@subcommand   = String.new
    @@description  = String.new

    def initialize
      @size          = 0
      @first_iter    = 0
      @drawSize      = 1.0
      @palette       = Colors::Palette.new
      @mod_functions = ["modulo"]
      @mod_function  = ModProc.new{ |n| BigInt.new 1 }
      @options       = Array(Options::GeneratorOption).new
    end

    # print settings
    def print_settings
      p! @size, @first_iter, @drawSize
    end
    
    # call `@mod_function` on all elements of `values`
    def modify(values)
      values.map do |n|
        @mod_function.call n
      end
    end
    
    # class variable getters
    def self.subcommand
      @@subcommand
    end
    def self.description
      @@description
    end

    # virtual methods
    def next
    end
    def modify
    end
    def output(stream=STDOUT)
    end
    def draw(ctx)
    end

    ### MODIFIER FUNCTIONS -------------------------------------------

    def modulo(modulus)
      ModProc.new do |n|
        n.modulo modulus
      end
    end

  end
end
