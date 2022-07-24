# frozen_string_literal: true

# Prints Welcome Msg, Prompts for and prints rules.
class Display

  def self.welcome
    puts 'Welcome. Let\'s play mastermind in the console.
Type "R" to print the rules or "enter" start the game.'
    selection = gets.chomp.upcase
    rules_check(selection)
  end

  def self.rules_check(selection)
    return unless selection == 'R'

    print_rules
    puts 'Type anything to start game'
    gets.chomp
  end

  def self.print_rules
    puts "One player is the codemaker and the other is the codebreaker.
  The codemaker chooses a pattern of between four and seven code pegs. Duplicates and blank spaces are allowed.
  The color options are. Red, Blue, Green, Yellow, Purple, Orange & Blank.
  The codebreaker tries to guess the pattern, in both order and color, within eight to twelve turns.
  Each guess is made by placing a row of code pegs on the decoding board.
  Once placed, the codemaker provides feedback by placing from zero to four
  key pegs that corespond with the guess the guess. A black key peg is placed
  for each code peg from the guess which is correct in both color and position.
  A white key peg indicates the existence of a correct color code peg placed in the wrong position.
  
  For example the Secret code is:
  Purple, Yellow, Green, Orange
  
  We guess:
  Red, Yellow, Purple, Purple
  
  The codemaster will return the following feedback:
  empty, Black, White, empty
  
  This lets us know that Yellow is both the correct color  and the correct position.  And that
  Purple is included in the Secret code but not in the guessed position.  On our next turn we would
  keep yellow in the 2nd position and include purple but perhaps in a different position.
  The codebreaker wins when they guess the code.  The Codemaker wins when all the guesses are exhausted.
  Have Fun!"
  end

  private_class_method :rules_check, :print_rules
end
