# frozen_string_literal: true

class Board #:nodoc:
  attr_reader :hidden_word, :hidden_arr 
  attr_accessor :remaining_guesses, :correct_guess

  def initialize
    @remaining_guesses = 6
    @hidden_word = generate_word
    @hidden_arr = @hidden_word.split('')
    @correct_guess = populate_correct_guess
  end

  def print_correct_guess
    puts "\nthe word is..."
    puts correct_guess.to_s
  end

  def decrease_guesses
    self.remaining_guesses -= 1
  end

  def print_art(num)
    file = File.open("art/art_#{num}.txt", 'r')
    data = file.read
    puts data
  end

  def print_hangman
    print_art(remaining_guesses)
    puts "#{remaining_guesses} guesses left"
  end

  private

  def generate_word()
    dic = File.open('5desk.txt') { |f| f.readlines }
    hid_wrd = dic[rand(dic.length)].chomp.upcase
    # puts "#{hid_wrd} #{hid_wrd.length}"     # Prints the word at the top of game for quick testing
    (5..12).include?(hid_wrd.length) ? hid_wrd : generate_word
  end

  def populate_correct_guess
    arr = []
    num = hidden_word.length
    num.times { arr << '_' }
    arr
  end
end
