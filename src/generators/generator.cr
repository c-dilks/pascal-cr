require "big"
require "celestine"
require "../colors"

module Mathographix

  alias ModProc = BigInt -> BigInt

  # base class for generators
  class Generator
    property drawSize, palette, mod_function
    @mod_function : ModProc

    def initialize
      @drawSize     = 1.0
      @palette      = Colors::Palette.new
      @mod_function = ModProc.new{ |n| BigInt.new 1 }
    end

    # call `@mod_function` on all elements of `values`
    def modify(values)
      values.map do |n|
        @mod_function.call n
      end
    end

    ### MODIFIER FUNCTIONS -------------------------------------------

    def modulo(modulus)
      ModProc.new do |n|
        n.modulo modulus
      end
    end

  end
end
