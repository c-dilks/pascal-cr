# generate pascal triangle
require "./pascal"

# arguments
ITER = ( ARGV[0]? || 5 ).to_i  # number of rows
MOD  = ( ARGV[1]? || 3 ).to_i  # modulus
SEED = ( ARGV[2]? || 1 ).to_i  # number in first row
p! ITER, MOD, SEED

# execution
outFile = File.new("output.txt","w")
row = Pascal::Row.new [BigInt.new SEED]
row.output outFile
ITER.times do |i|
  row.next
  row.modulo MOD
  row.output outFile
end
outFile.close
