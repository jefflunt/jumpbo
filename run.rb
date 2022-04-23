require 'colorize'
require_relative './jumpbo'

j = Jumpbo.new(2)

puts "NEW GAME".yellow
puts j
puts

j.play_game
puts j
