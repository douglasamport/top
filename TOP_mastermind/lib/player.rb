# frozen_string_literal: true

require './lib/board'
require './lib/pegs'

# This class sets up the player and provides a method to set the secret code, set a guess and provide feedback.
class Player
  include Pegs
  attr_reader :name, :codemaker

  def initialize(name, role)
    @name = name
    @codemaker = role
  end

  def prep_secret_code(board)
    puts "\nTime to set the code.  You'll now choose exactly #{board.pegs} pegs."
    puts "Remember you can use 'Blank' and you can use the same color twice."
    puts 'Color options are Red, Blue, Green, Yellow, Purple, Orange & Blank'
    arr = []
    board.pegs.times { |i| arr << peg_choice(i, "\nChoose", COLOR_PEGS)}
    arr
  end

  def guess(board)
    puts "\nMake your guess."
    puts 'Color options are Red, Blue, Green, Yellow, Purple, Orange & Blank'
    arr = []
    board.pegs.times { |i| arr << peg_choice(i, "\nChoose", COLOR_PEGS)}
    arr
  end

  def provide_feedback(board)
    puts "\nProvide Feedback Black, White or Empty"
    puts "code = #{board.secret_code}"
    puts "guess = #{board.current_guess}"
    arr = []
    board.pegs.times { |i| arr << peg_choice(i, "\nFeedback", FEEDBACK_PEGS)}
    arr
  end

  private

  def peg_choice(i, str_type, const_arr)
    puts "#{str_type} Peg #{i + 1}."
    peg = gets.chomp.downcase.strip
    return peg if const_arr.include?(peg)

    puts "That's not an option. Color options are #{const_arr.join(', ')}."
    peg_choice(i, str_type, const_arr)
  end

  def self.check_codemaker(name)
    puts "\nHello #{name} Would you like to be the Code Braker or Code Maker?
    Type 'B' for Codebreaker or 'M' for Codemaker"
    selection = gets.chomp.upcase
    return selection == 'M' if %w[B M].include?(selection)

    puts 'I\'m sorry.  That selection is Invalid.   Type B for Codebreaker and M for Codemaker'
    check_codemaker(name)
  end

  public

  def self.player_setup
    puts 'Please enter the Players name'
    temp_name = gets.chomp
    temp_role = check_codemaker(temp_name)
    Player.new(temp_name, temp_role)
  end

  private_class_method :check_codemaker
end
