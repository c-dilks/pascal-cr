# generate pascal triangle
require "option_parser"
require "./generators/*"

# default settings
outBN      = "output"
outDir     = "out"
outFormats = [ :txt, :svg ]
drawSize   = 2.0
colormap   = "lava"

# internal settings
outMode   = outFormats.map{ |ext| [ext,false] }.to_h
sep       = "-"*60
stopEarly = false

# list of supported generators
gen_list = [
  Mathographix::Pascal,
]

# modifiers (todo)
modulus  = 17

# parse options
gen = Mathographix::Generator.new
OptionParser.parse do |p|
  p.banner =  "
               +============+
              / Mathographix \\
             +================+

  Usage: math [GENERATOR] [MODIFIER] [ARUMENTS]...
  "
  p.on "-h", "--help", "show help" do
    puts p
    exit
  end
  p.on "-D", "--dry-run", "dry run, just show all settings and exit" { stopEarly = true }
  p.separator sep

  # generator subcommand
  p.separator "[GENERATOR]: choose one of the following generators:"
  gen_list.each do |gen_class|
    p.on( gen_class.subcommand, gen_class.description) do
      gen = gen_class.new
      p.separator sep
      p.separator "#{gen_class.description} OPTIONS:"
      gen.options.each do |opt|
        p.on(opt.short_flag, opt.long_flag, opt.description) { |s| opt.action.call(s) }
      end
    end
  end
  p.separator "NOTE: run `math [GENERATOR] -h` to show generator-specific options"
  p.separator sep

  # modifier subcommand (todo)
  p.on "-m MODULUS",  "modulus"                    { |n| modulus = n.to_i }

  # general options
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
p! modulus, outName, outMode, drawSize, colormap
puts sep
gen.print_settings
puts sep
exit if stopEarly

# open output files
Dir.mkdir outDir unless Dir.exists? outDir
outTxt = File.new("#{outName}.txt","w") if outMode[:txt]
outSvg = File.new("#{outName}.svg","w") if outMode[:svg]

# set modifier
palette_range_min = 0
palette_range_max = 1
mod_function = "modulo"
case mod_function
when "modulo"
  gen.mod_function = gen.modulo(modulus)
  palette_range_max = modulus
when "modulo_row"
  gen.mod_function = gen.modulo(modulus)
  # gen.mod_function_update_mode = "modulo_row" # todo fix this
  # palette_range_max = gen.size # todo fix this
else
  STDERR.puts "ERROR: unknown modifier function '#{mod_function}'; using default"
end


# execution ---------------------------------------------------
svg = Celestine.draw do |ctx|

  # common generator settings
  gen.drawSize = drawSize
  gen.palette.set_gradient colormap
  gen.palette.set_range palette_range_min, palette_range_max

  # skip to iteration number `gen.first_iter`
  gen.first_iter.times.each do gen.next end

  # output proc
  produce = -> {
    gen.modify
    gen.output outTxt.as(File) if outMode[:txt]
    gen.draw ctx if outMode[:svg]
  }
  produce.call

  # loop over rows
  gen.size.times do |i|
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
