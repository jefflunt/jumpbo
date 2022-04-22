require 'colorize'
require_relative './jumpbo'

j = Jumpbo.new(2)

puts "NEW GAME".yellow
puts j
puts

puts "TURN #{j.turn + 1}, Player #{j.player_i + 1}"
j.take_turn

puts "TURN #{j.turn + 1}, Player #{j.player_i + 1}"
j.take_turn

puts "TURN #{j.turn + 1}, Player #{j.player_i + 1}"
j.take_turn

puts "TURN #{j.turn + 1}, Player #{j.player_i + 1}"
j.take_turn

puts "TURN #{j.turn + 1}, Player #{j.player_i + 1}"
j.take_turn

puts "TURN #{j.turn + 1}, Player #{j.player_i + 1}"
j.take_turn

puts "TURN #{j.turn + 1}, Player #{j.player_i + 1}"
j.take_turn

puts "TURN #{j.turn + 1}, Player #{j.player_i + 1}"
j.take_turn

puts "TURN #{j.turn + 1}, Player #{j.player_i + 1}"
j.take_turn

puts "TURN #{j.turn + 1}, Player #{j.player_i + 1}"
j.take_turn
