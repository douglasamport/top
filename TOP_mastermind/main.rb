# frozen_string_literal: true

require './lib/display'
require './lib/player'
require './lib/computer'
require './lib/game'
require './lib/board'

Display.welcome

player = Player.player_setup

board = Board.new
computer = Computer.new(!player.codemaker, board)
game = Game.new(player, computer, board)
