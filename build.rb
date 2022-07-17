#!/usr/bin/env ruby

target = "pascal"

buildCommand = [
  "crystal build",
  ARGV.size>0 ? ARGV.join(' ') : "",
  "-o #{target}",
  "-Dpreview_mt",
  "src/run.cr",
].join " "

puts "buildCommand => #{buildCommand}"
puts "target       => #{target}"
success = system buildCommand
puts "=> build #{success ? "successful" : "failed"}"
exit success ? 0 : 1
