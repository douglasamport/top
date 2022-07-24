# frozen_string_literal: true

class Board
  attr_reader :empty
  attr_accessor :array

  def initialize(rows = 6, columns = 7)
    @rows = rows
    @columns = columns
    @empty = "\u25CB"
    @array = Array.new(@rows) { Array.new(@columns, @empty)}
  end

  def render_array
    puts ''
    @array.each { |row| 
    puts "     #{row.join('  ')}"
    }
    puts "    #{Array.new(7, '---').join('')}"
    puts "     #{Array(1..7).join('  ')}"
  end
  
  def drop(col, player, row = 5)
    while row >= 0
      if array[row][col - 1] == empty
        array[row][col - 1] = player.symbol
        break
      end
      row -= 1
    end
  end

  def collumn_full?(col)
    array[0][col - 1] != empty ? true : false
  end

end
