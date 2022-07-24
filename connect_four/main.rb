require './lib/board.rb'
require './lib/player.rb'
require './lib/game.rb'

game = Game.new

game.setup

game.round(game.players)
