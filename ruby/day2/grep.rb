#!/usr/bin/env ruby

file_name = ARGV[0]
text = ARGV[1]

File.foreach(file_name) {|line| puts line if line.include?(text) }

