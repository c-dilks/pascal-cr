#!/usr/bin/env crystal

target = "pascal"

buildCommand = [
  "crystal build",
  ARGV.size>0 ? ARGV.join(' ') : "",
  "-o #{target}",
  "src/run.cr",
].join " "

p! buildCommand, target
success = system buildCommand
puts "=> build #{success ? "successful" : "failed"}"
