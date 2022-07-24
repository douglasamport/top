# frozen_string_literal: true

class Computer
  attr_reader :name, :color
  attr_accessor :symbol

  def initialize(color)
    @name = "Computer"
    @color = color
    @symbol = setup_computer_symbol
    @first = setup_computer_first
  end

  def setup_player_symbol
    @color == 'W' ? "\e[37m\u25CF\e[0m" : "\e[31m\u25CF\e[0m"
  end


  def setup_player_first
    @color == 'W'
  end

end