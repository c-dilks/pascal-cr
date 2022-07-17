# generate pascal triangle
require "./pascal"

# arguments
NUM_ROWS = ( ARGV[0]? || 100 ).to_i # number of rows to generate
MODULUS  = ( ARGV[1]? || 9   ).to_i # modulus
SEED     = ( ARGV[2]? || 1   ).to_i # number in first row
p! NUM_ROWS, MODULUS, SEED

# settings
OUTPUT_TXT = false
OUTPUT_SVG = true

# execution ---------------------------------------------------
outFile = File.new("output.txt","w") if OUTPUT_TXT
outSvg  = File.new("output.svg","w") if OUTPUT_SVG
svg = Celestine.draw do |ctx|

  # start the triangle, given a seed row (default is `[1]`)
  triangle = Pascal::Row.new [BigInt.new SEED]

  # output proc
  output = -> {
    triangle.output outFile.as(File) if OUTPUT_TXT
    triangle.draw ctx, NUM_ROWS+1 if OUTPUT_SVG
  }
  output.call # output seed row

  # loop over rows
  NUM_ROWS.times do |i|
    triangle.next
    triangle.modulo MODULUS
    output.call
  end

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
