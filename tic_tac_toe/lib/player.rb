# frozen_string_literal: true

class Player #:nodoc:

  attr_accessor :name, :symbol, :first

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @first = symbol == 'X' ? true : false
  end

end
