# frozen_string_literal: true

require './lib/board'
require './lib/game'
require './lib/player'
require './lib/setup'
require 'pry'
require 'pry-byebug'

Setup.greeting

if File.exist?('saved/saved_game.txt')
  puts "\nWould you like to load a saved game? Press 'Y' to load a file or any other key to continue"
  reply = gets.chomp.upcase
  if reply == 'Y'
    fname = 'saved/saved_game.txt'
    game = Game.load(fname)
    Game.new(game.player, game.board)
  end
end
player = Player.setup
board = Board.new
Game.new(player, board)
