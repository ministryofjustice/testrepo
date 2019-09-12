#!/usr/bin/env ruby

puts "Hello from ruby"
pp ENV
puts "Github event..."
puts File.read("/home/runner/work/_temp/_github_workflow/event.json")
