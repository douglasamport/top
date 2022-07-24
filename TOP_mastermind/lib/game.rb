# frozen_string_literal: true

# prompts player to pick guesses, and runs the game rounds. Relies heavlily on Board class.
class Game
  attr_reader :guesses, :codemaker, :codebreaker, :board, :used_guesses

  def initialize(player, computer, board)
    @codemaker = player.codemaker ? player : computer
    @codebreaker = player.codemaker ? computer : player
    @guesses = pick_guesses
    @used_guesses = 0
    @board = board
    start_game(@board)
  end

  private

  def pick_guesses
    puts "\nEnter the number of Guesses you'd like for this game, between 8 and 12"
    num = gets.chomp.to_i
    return num if (8..12).include?(num)

    puts "\nThat's not a number between 8 and 12"
    pick_guesses
  end

  def start_game(board)
    board.secret_code = codemaker.prep_secret_code(board)
    round(board)
  end

  def round(board)
    print_latest_feeback(board)
    board.current_guess = codebreaker.guess(board)
    @used_guesses += 1
    print_latest_guess(board)
    puts "#{guesses - used_guesses} guesses left"
    check_winning_match(board)
    board.current_feedback = feedback_checker(codemaker, board)
    check_out_of_guesses
    round(board)
  end

  def feedback_checker(role, board)
    comp_arr = []
    guess = board.current_guess
    code = board.secret_code
    feedback_switchboard(comp_arr, guess, code)
    role.name == 'Computer' ? comp_arr : get_plr_feedback(role, board, comp_arr)
  end

  def feedback_switchboard(comp_arr, guess, code)
    guess.each_with_index do |color, i|
      comp_arr << if color == code[i]
                    'black'
                  elsif code.include?(color)
                    'white'
                  else
                    'empty'
                  end
    end
  end

  def get_plr_feedback(role, board, comp_arr)
    plr_feedback = role.provide_feedback(board)
    if plr_feedback == comp_arr
      plr_feedback
    else
      puts "\nThat feedback seems misleading. Don't cheat! #{comp_arr}"
      get_plr_feedback(role, board, comp_arr)
    end
  end

  def print_latest_feeback(board)
    return unless board.current_feedback.empty?

    puts "\nCode Maker says..."
    puts board.current_feedback.to_s
  end

  def print_latest_guess(board)
    return unless board.current_guess.empty?

    puts "\nCode Breaker guesses..."
    puts board.current_guess.to_s
  end

  def check_winning_match(board)
    return unless board.current_guess == board.secret_code

    puts "\n#{codebreaker.name} Wins!  #{codebreaker.name} cracked the code!"
    exit
  end

  def check_out_of_guesses
    return unless used_guesses >= guesses

    puts "\n#{codemaker.name} Wins!  #{codebreaker.name} couldn't crack the code!"
    exit
  end
end
