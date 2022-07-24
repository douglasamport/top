# frozen_string_literal: true

class Setup #:nodoc:
  def self.greeting
    puts "Welcome to 'Hangman' in the console.  The computer will choose a word at random and 
each turn you'll have the opporutnity to guess one letter.  If you guess right you'll get to guess again.  
You'll get six wrong guesses before you're hung."

    puts "\nYou'll win if you guess all the letters correctly.  If, during your turn you want to save and exit your game type
'save' instead of a letter.  Good Luck."
  end
end