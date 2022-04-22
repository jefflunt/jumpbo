require 'colorize'
require_relative './jumpbo'

j = Jumpbo.new(4)

puts "NEW GAME".yellow
puts j
puts

j.play_game
puts j
