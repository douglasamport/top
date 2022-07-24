# frozen_string_literal: true

# Prompts player to pick number of Pegs, tracks secret code, guesses, and feedback.
class Board
  attr_reader :color_pegs, :pegs
  attr_accessor :secret_code, :current_guess, :current_feedback, :past_guesses, :past_feedback

  def initialize
    @secret_code = []
    @current_guess = []
    @current_feedback = []
    @pegs = pick_peg_number
  end

  private

  def pick_peg_number
    puts "\nEnter the number of Pegs you\'d like for this game, between 4 and 7"
    num = gets.chomp.to_i
    return num if (4..7).include?(num)

    puts "\nThat\'s not a number between 4 and 7"
    pick_peg_number
  end
end
