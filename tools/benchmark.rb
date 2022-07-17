#!/usr/bin/env ruby
# time how long it takes to generate triangles

require 'awesome_print'
require 'open3'

# settings
timeCmd = `which time`.chomp

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
  cmd = [
    "#{timeCmd} -v",
    "./pascal #{benchmark[:args].join ' '}",
  ].join ' '
  ap cmd
  outs, errs, status = Open3.capture3(cmd)

  # `time` outputs to `stderr`
  benchmark[:time] = errs
    .split(/\n/)
    .map{ |line| line.gsub(/^\t/,'') }
end
puts "done running benchmarks\n".upcase

# print
ap benchmarks
