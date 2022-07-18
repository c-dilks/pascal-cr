# generate pascal triangle
require "./pascal"
require "option_parser"

# default settings
numRows    = 17*17
modulus    = 17
seed       = [BigInt.new 1]
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
               +=========================+
              / Pascal Triangle Generator \\
             +=============================+
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
p! numRows, modulus, seed, outName, outMode, drawSize, colormap
puts sep
exit if stopEarly

# open output files
Dir.mkdir outDir unless Dir.exists? outDir
outTxt = File.new("#{outName}.txt","w") if outMode[:txt]
outSvg = File.new("#{outName}.svg","w") if outMode[:svg]

# execution ---------------------------------------------------
svg = Celestine.draw do |ctx|

  # start the triangle, given a seed row (default is `[1]`)
  triangle = Pascal::Row.new numRows, seed
  triangle.drawSize = drawSize
  triangle.palette.set_gradient colormap
  triangle.palette.set_range 0, modulus-1

  # output proc
  produce = -> {
    triangle.modulo modulus
    triangle.output outTxt.as(File) if outMode[:txt]
    triangle.draw ctx if outMode[:svg]
  }
  produce.call # seed row

  # loop over rows
  numRows.times do |i|
    triangle.next
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
