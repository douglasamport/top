# frozen_string_literal: true

require 'pry'
require 'pry-byebug'
require './lib/persistence'

# current class comment
class Game
  include Persistence

  attr_accessor :player, :board

  def initialize(player, board)
    @board = board
    @player = player
    round(player, board)
  end

  private

  def wrong(ltr, player, board)
    puts "\n#{ltr} is not included."
    board.decrease_guesses
    board.print_hangman
    check_for_loser(player, board)
  end

  def correct(ltr, player, board)
    puts "\n#{ltr} is included."
    board.hidden_arr.each_with_index { |chr, idx| board.correct_guess[idx] = ltr if chr == ltr }
    check_for_winner(player, board)
  end

  def round(player, board)
    board.print_correct_guess
    ltr = player.guess_letter
    save_game() if ltr == 'SAVE'
    player.previously_guessed << ltr
    board.hidden_arr.include?(ltr) ? correct(ltr, player, board) : wrong(ltr, player, board)
    round(player, board)
  end

  def save_game
    save
    puts 'Game has been Saved.'
    exit
  end

  def play_again?(player)
    puts "\nWould you like to play again? Enter'Y' to play or any other key to exit."
    reply = gets.chomp.upcase
    if reply == 'Y'
      player.previously_guessed = []
      board = Board.new
      Game.new(player, board)
    else
      exit
    end
  end

  def check_for_loser(player, board)
    return unless board.remaining_guesses.zero?

    puts "\n#{player.name} you Lose! The word was #{board.hidden_word}."
    play_again?(player)
  end

  def check_for_winner(player, board)
    return unless board.correct_guess == board.hidden_arr

    puts "\n#{player.name} You Win!  The word is #{board.hidden_word}."
    play_again?(player)
  end
end
