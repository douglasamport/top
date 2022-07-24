require './lib/board.rb'

row1 = ['0', 'R', '0', 'R', '0', '0', '0']
row2 = ['0', '0', 'R', 'R', 'R', 'R', '0']
row3 = ['0', 'R', '0', 'R', '0', 'R', '0']
row4 = ['R', 'R', '0', 'R', 'R', 'R', '0']

board1 = [row1, row2, row3, row4]

board = Board.new
board2 = board.array
board2[4] = row2

def test_board_rows(board, x = 0, y = 0, queue = Array.new(4))
  until board[x].nil?
    queue << board[x][y]
    queue.shift()
    return true if queue.all?('R') || queue.all?('W')

    y += 1
    next unless board[x][y].nil?

    x += 1 
    y = 0 
    queue = Array.new(4)

  end
end

puts test_board_rows(board2)

puts test_board_rows(board1)

def test_board_cols(board, x = 0, y = 0, queue = Array.new(4))
  until board[y].nil?
    queue << board[x][y]
    queue.shift
    return true if queue.all?('R') || queue.all?('W')

    x += 1
    next unless board[x].nil?

    y += 1
    x = 0 
    queue = Array.new(4)
  end
end

# puts test_board_cols(board1)
# puts test_board_cols(board2)

def test_board_rgtagls(board)
  right_first_half(board) || right_second_half(board)
end

def right_first_half(board, start = [(board.length - 1), 0])
  until start == [0, 0]
    return true if increment_queue_right(board, start[0], start[1])
    
    start[0] -= 1
  end
end

def right_second_half(board, start = [0, 0])
  until board[start[0]][start[1]].nil?
    return true if increment_queue_right(board, start[0], start[1])

    start[1] += 1
  end
end

def increment_queue_right(board, x, y, queue = Array.new(4))
  until board[x].nil? || board[x][y].nil?
    queue << board[x][y]
    queue.shift
    #puts "#{x}, #{y}, #{queue}"
    return true if queue.all?('R') || queue.all?('W')

    x += 1
    y += 1
  end
end

# puts right_first_half(board1)
# puts right_second_half(board1)

# puts right_first_half(board2)
# puts right_second_half(board2)



# puts test_board_rgtagls(board1)
# puts test_board_rgtagls(board2)


def test_board_lftagls(board)
  left_first_half(board) || left_second_half(board)
end

def left_first_half(board, start = [(board.length - 1), board[0].length - 1])
  until start[0].zero?
    return true if increment_queue_left(board, start[0], start[1])

    start[0] -= 1
  end
end

def left_second_half(board, start = [0, 6])
  until board[start[0]][start[1]].nil?
    return true if increment_queue_left(board, start[0], start[1])

    start[1] -= 1
    break if start[1] < 0 
  end
end

def increment_queue_left(board, x, y, queue = Array.new(4))
  until board[x].nil? || board[x][y].nil?
    queue << board[x][y]
    queue.shift
    puts "#{x}, #{y}, #{queue}"
    return true if queue.all?('R') || queue.all?('W')

    x += 1
    y -= 1
    break if y.negative?\
  end
end

# puts test_board_lftagls(board1)
# puts test_board_lftagls(board2)


# Write test for game_spec for winning
# write test for game_spec draw
#implemet winning methods