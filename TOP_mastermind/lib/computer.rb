# frozen_string_literal: true

require './lib/board'
require './lib/pegs'

# Chooses secret code for and determines guesses for Computer. Computer feedback is provided by Game.rb
class Computer
  include Pegs
  attr_reader :name, :options
  attr_accessor :include_in_guess, :exclude_from_guess

  def initialize(role, board)
    @name = 'Computer'
    @codemaker = role
    @options = build_computer_options(board)
  end

  def build_computer_options(board)
    arr = []
    board.pegs.times do
      arr << { 'include' => [], 'exclude' => [], 'lock' => [] }
    end
    arr
  end

  def prep_secret_code(board)
    arr = []
    board.pegs.times { |i| arr << random_peg_choice() }
    puts "#{name} has set the code"
    arr
  end

  def guess(board)
    filter_feedback(board)
    arr = []
    board.pegs.times { |i| arr << calc_peg_choice(i, board) }
    arr
  end

  private

  def calc_peg_choice(i, board)
    lock_arr = options[i]['lock']
    include_arr = options[i]['include']
    exclude_arr = COLOR_PEGS - options[i]['exclude']
    feedback_peg = board.current_feedback[i]
    peg_switchboard(lock_arr, include_arr, exclude_arr, feedback_peg)
  end

  def peg_switchboard(lock_arr, include_arr, exclude_arr, feedback_peg)
    # return the same peg when black is given back
    return lock_arr[0] if lock_arr.any?
    # return the next peg from the included set first than a filtered random peg.
    return white_peg_choice(include_arr, exclude_arr) if feedback_peg == 'white'
    # return a random peg from the inclued set first then a filtered random peg.
    return empty_peg_choice(include_arr, exclude_arr) if feedback_peg == 'empty'

    random_peg_choice
  end

  def empty_peg_choice(include_arr, exclude_arr)
    include_arr.length >= 1 ? include_arr[rand(include_arr.length)] : exclude_arr[rand(exclude_arr.length)]
  end

  def white_peg_choice(include_arr, exclude_arr)
    include_arr.length >= 1 ? include_arr.shift : exclude_arr[rand(exclude_arr.length)]
  end

  def filter_feedback(board)
    board.current_feedback.each_with_index do |peg, x|
      current = board.current_guess[x]
      locked = options[x]['lock']
      filter_feedback_black(locked, current, peg)
      filter_feedback_white(x, current, peg)
      filter_feedback_empty(board, current, peg)
    end
    filter_feedback_subtract
  end

  def filter_feedback_black(locked, current, peg)
    locked << current if peg == 'black'
    locked.uniq! if locked.length > 1
  end

  def filter_feedback_white(x, current, peg)
    return unless peg == 'white'

    options[x]['exclude'] << current
    options.map { |hash| hash['include'] << current unless hash['include'].include?(current) }
  end

  def filter_feedback_empty(board, current, peg)
    board.pegs.times { |y| options[y]['exclude'] << current} if peg == 'empty'
  end

  def filter_feedback_subtract
    options.map do |hash| 
      hash['include'] -= hash['exclude']
      hash['exclude'].uniq! if hash['exclude'].length > 1
    end
  end

  def random_peg_choice
    COLOR_PEGS[rand(7)]
  end
end
