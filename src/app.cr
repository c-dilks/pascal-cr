# generate pascal triangle
require "option_parser"
require "./generators/*"

# default settings
generator_type = "pascal"
mod_function = "modulo"
numRows    = 17*17
modulus    = 17
seed       = [BigInt.new 1]
beginRow   = 0
outBN      = "output"
outDir     = "out"
outFormats = [ :txt, :svg ]
drawSize   = 2.0
colormap   = "lava"

# internal settings
outMode   = outFormats.map{ |ext| [ext,false] }.to_h
sep       = "-"*60
stopEarly = false

# parse options
OptionParser.parse do |p|
  p.banner =  "
               +============+
              / Mathographix \\
             +================+
  "
  p.on "-h", "--help", "show help" do
    puts p
    exit
  end
  p.on "-H", "--dump", "show all settings and exit" { stopEarly = true }
  p.separator sep
  p.separator "generator settings:"
  p.on "-n NUM_ROWS", "number of rows to generate" { |n| numRows = n.to_i }
  p.on "-m MODULUS",  "modulus"                    { |n| modulus = n.to_i }
  p.on "-s SEED", "seed row number(s), e.g., `-s 1,2,3`" do |s|
    seed = s.split(',').map{ |n| BigInt.new n }
  end
  p.on "-b BEGINROW",  "row number to begin output on" { |n| beginRow = n.to_i }
  p.separator sep
  p.separator "output file directory and filename prefix:"
  p.on "--outdir OUTDIR", "output directory"     { |s| outDir = s.gsub(/\/$/,"") }
  p.on "--prefix PREFIX", "output file basename" { |s| outBN  = s               }
  p.separator sep
  p.separator "output formats:"
  p.separator "If you choose none, an SVG file will be produced"
  outFormats.each do |ext|
    p.on "--#{ext.to_s}", "enable #{ext.to_s.upcase} output" { outMode[ext] = true }
  end
  p.separator sep
  p.separator "draw settings:"
  p.on "-d SIZE",     "--draw-size SIZE", "size of each drawn SVG element" { |n| drawSize = n.to_f }
  p.on "-c COLORMAP", "--color COLORMAP", "palette color map"              { |s| colormap = s      }
  p.separator "     > available COLORMAPs:"
  p.separator Colors::Palette.new.help
end

# post-parse settings
outName = [outDir,outBN].join '/'
outMode[:svg] = true if outMode.values.find{|v|v}.nil?

# print settings
puts sep
puts "settings".upcase
p! numRows, modulus, seed, beginRow, outName, outMode, drawSize, colormap
puts sep
exit if stopEarly

# open output files
Dir.mkdir outDir unless Dir.exists? outDir
outTxt = File.new("#{outName}.txt","w") if outMode[:txt]
outSvg = File.new("#{outName}.svg","w") if outMode[:svg]

# set generator
case generator_type
when "pascal"
  gen = Mathographix::Pascal.new numRows, seed, beginRow
else
  STDERR.puts "ERROR: unknown generator type '#{generator_type}'"
  exit 1
end

# set modifier
palette_range_min = 0
palette_range_max = 1
case mod_function
when "modulo"
  gen.mod_function = gen.modulo(modulus)
  palette_range_max = modulus
when "modulo_row"
  gen.mod_function = gen.modulo(modulus)
  gen.mod_function_update_mode = "modulo_row"
  palette_range_max = numRows
else
  STDERR.puts "ERROR: unknown modifier function '#{mod_function}'; using default"
end


# execution ---------------------------------------------------
svg = Celestine.draw do |ctx|

  # common generator settings
  gen.drawSize = drawSize
  gen.palette.set_gradient colormap
  gen.palette.set_range palette_range_min, palette_range_max

  # skip to row number `beginRow`
  beginRow.times.each do gen.next end

  # output proc
  produce = -> {
    gen.modify
    gen.output outTxt.as(File) if outMode[:txt]
    gen.draw ctx if outMode[:svg]
  }
  produce.call # seed row

  # loop over rows
  numRows.times do |i|
    gen.next
    produce.call
  end

end

# cleanup -----------------------------------------------------
puts "\nOUTPUTS:"
if outMode[:txt]
  puts "#{outName}.txt"
  outTxt.as(File).close
end
if outMode[:svg]
  outSvg.as(File).puts svg
  puts "#{outName}.svg"
  outSvg.as(File).close
end
