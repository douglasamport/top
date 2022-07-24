# frozen_string_literal: true

require 'pry'
require 'pry-byebug'

class Player #:nodoc:

  attr_reader :name
  attr_accessor :previously_guessed

  def initialize(name)
    @name = name
    @previously_guessed = []
  end

  def guess_letter
    puts "\nYou've already guessed #{previously_guessed.join(', ')}." unless previously_guessed.empty?
    puts "Make your guess."
    chr = gets.chomp.upcase
    return chr if chr == 'SAVE'

    ('A'..'Z').include?(chr) ? chr : guess_letter
  end

  def self.setup
    puts 'Please enter your name.'
    name = gets.chomp
    puts "Welcome #{name}"
    Player.new(name)
  end
end
