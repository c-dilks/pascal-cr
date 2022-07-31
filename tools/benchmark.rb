#!/usr/bin/env ruby
# time how long it takes to generate triangles

require 'awesome_print'
require 'open3'

# list of `pascal` jobs and their arguments to run
benchmarks = [
  { :args=>[ "-n 100",  "-m 7"  ] },
  { :args=>[ "-n 1000", "-m 11" ] },
  { :args=>[ "-n 2000", "-m 9"  ] },
  { :args=>[ "-n 3000", "-m 3"  ] },
]

####################################################

# build
success = system "./build.rb --release"
exit 1 if not success

# run benchmarks
puts "\nrunning benchmarks".upcase
benchmarks.each do |benchmark|

  # run
  cmd = "./pascal #{benchmark[:args].join ' '}"
  ap cmd
  time_start = Time.now
  outs, errs, status = Open3.capture3(cmd)
  time_stop = Time.now
  benchmark[:time] = time_stop - time_start

end
puts "done running benchmarks\n".upcase

# print
ap benchmarks
