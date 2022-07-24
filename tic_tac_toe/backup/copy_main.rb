# frozen_string_literal: true

require './lib/player'
require './lib/game'

puts "Hi, Let\'s play Tic-Tac-Toe in the console."

2.times { |i| Player.setup_players(i) }

Game.new