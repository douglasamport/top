# frozen_string_literal: true

class Player
  attr_reader :name, :color
  attr_accessor :symbol, :first

  def initialize(name, color)
    @name = name
    @color = color
    @symbol = setup_player_symbol
    @first = setup_player_first
  end

  def setup_player_symbol
    @color == 'W' ? "\e[37m\u25CF\e[0m" : "\e[31m\u25CF\e[0m"
  end


  def setup_player_first
    @color == 'W'
  end

end