#!/usr/bin/env ruby

target = "math"

buildCommand = [
  "crystal build",
  ARGV.size>0 ? ARGV.join(' ') : "",
  "-o #{target}",
  "src/app.cr",
].join " "

puts "buildCommand => #{buildCommand}"
puts "target       => #{target}"
success = system buildCommand
puts "=> build #{success ? "successful" : "failed"}"
exit success ? 0 : 1
