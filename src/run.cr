# generate pascal triangle
require "./pascal"

# arguments
ITER = ( ARGV[0]? || 100 ).to_i # number of rows
MOD  = ( ARGV[1]? || 9   ).to_i # modulus
SEED = ( ARGV[2]? || 1   ).to_i # number in first row
p! ITER, MOD, SEED

# settings
OUTPUT_TXT = true
OUTPUT_SVG = true

# execution ---------------------------------------------------
outFile = File.new("output.txt","w") if OUTPUT_TXT
outSvg  = File.new("output.svg","w") if OUTPUT_SVG
svg = Celestine.draw do |ctx|

  # start the triangle, given a seed row (default is `[1]`)
  row = Pascal::Row.new [BigInt.new SEED], ITER

  # output proc
  output = -> {
    row.output outFile.as(File) if OUTPUT_TXT
    row.draw ctx if OUTPUT_SVG
  }
  output.call # output seed row

  # loop over rows
  ITER.times do |i|
    row.next
    row.modulo MOD
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
