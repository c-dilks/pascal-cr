# generate pascal triangle
require "./pascal"

# arguments
NUM_ROWS = ( ARGV[0]? || 100 ).to_i # number of rows to generate
MODULUS  = ( ARGV[1]? || 9   ).to_i # modulus
SEED     = ( ARGV[2]? || 1   ).to_i # number in first row
p! NUM_ROWS, MODULUS, SEED

# settings
OUTPUT_TXT = true
OUTPUT_SVG = true
CONCURRENT_BUFFER_SIZE = 5

# execution ---------------------------------------------------
channel = Channel(Pascal::Row).new(CONCURRENT_BUFFER_SIZE)
outFile = File.new("output.txt","w") if OUTPUT_TXT
outSvg  = File.new("output.svg","w") if OUTPUT_SVG
svg = Celestine.draw do |ctx|

  # start the triangle, given a seed row (default is `[1]`)
  triangle = Pascal::Row.new [BigInt.new SEED]

  # output proc
  output = ->(t : Pascal::Row) {
    t.output outFile.as(File) if OUTPUT_TXT
    t.draw ctx, NUM_ROWS+1 if OUTPUT_SVG
  }
  output.call triangle # output seed row

  # `next` fibers: compute the next row, stored in `@nums` of `triangle`. Sends
  # a clone of `triangle` to the buffer
  spawn do
    NUM_ROWS.times do |i|
      puts "next: #{i}"
      triangle.next
      channel.send(triangle.clone)
    end
  end

  # `modify` fibers: run the desired `modify` function on the `Row` received
  # from the buffer
  spawn do
    NUM_ROWS.times do |i|
      t = channel.receive
      puts "#{" "*30}modify: #{i}"
      t.modulo MODULUS
      output.call t
    end
  end

  # yield to fibers
  Fiber.yield
end

# cleanup -----------------------------------------------------
puts "\nOUTPUTS:"
if OUTPUT_TXT
  p! outFile
  outFile.as(File).close
end
if OUTPUT_SVG
  outSvg.as(File).puts svg
  p! outSvg
  outSvg.as(File).close
end
