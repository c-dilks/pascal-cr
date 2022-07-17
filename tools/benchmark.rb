#!/usr/bin/env ruby
# time how long it takes to generate triangles

require 'awesome_print'
require 'open3'

system "./build.rb --release"

# list of `pascal` jobs and their arguments to run
benchmarks = [
  { :args=>[ 100,  7  ] },
  { :args=>[ 1000, 11 ] },
  { :args=>[ 2000, 9  ] },
  { :args=>[ 3000, 3  ] },
]

# run benchmarks
benchmarks.each do |benchmark|

  # run
  cmd = "time -v ./pascal #{benchmark[:args].join ' '}"
  ap cmd
  outs, errs, status = Open3.capture3(cmd)

  # `time` outputs to `stderr`
  benchmark[:time] = errs
    .split(/\n/)
    .map{ |line| line.gsub(/^\t/,'') }
end

# print
ap benchmarks
