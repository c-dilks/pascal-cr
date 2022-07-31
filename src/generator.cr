require "big"
require "celestine"
require "./colors"

module MathGen

  # base class for generators, such as PascalTriangle or UlamSpiral
  class Generator
    property drawSize, palette

    def initialize
      @drawSize = 1.0
      @palette  = Colors::Palette.new
    end

    # run a calculation on each element of `value_list`, returning the resulting Array
    def modify(value_list)
      value_list.map{ |n| yield n }
    end

    # return `value_list modulo m`
    def modulo(value_list,m)
      modify(value_list) do |n|
        n.modulo m
      end
    end

    # catch missing methods
    def method_missing(name,*args)
      STDERR.puts "WARNING: method '#{name}' is not defined for this generator"
    end

  end
end
