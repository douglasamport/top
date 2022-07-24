# frozen_string_literal: true

class Game
  attr_accessor :players

  def initialize
    @players = []
  end

  def setup
    welcome
    num = 2 # temp choice untill computer player is setup
    num.times { |a| players << player_setup(a) }
    # this is where the computer player setup would enter
    Board.new.render_array
  end

  def computer_player_setup
    Computer.new
  end

  def welcome
    puts 'Welcome to Connect Four in the Console'
  end

  def number_of_players
    puts 'Type 1 for one player (Player vs. Computer) or 2 for Two players (Player vs. Player)'
    arr = %w[1 2]
    picker_loop(arr).to_i
  end

  def picker_loop(arr)
    loop do
      elmnt = verify_input(player_input, arr)
      return elmnt if arr.include?(elmnt)

      puts error_msg_invalid_input
    end
  end

  def verify_input(input, arr)
    input if arr.include?(input)
  end

  def player_input
    gets.chomp.upcase
  end

  def error_msg_invalid_input
    'That input is invalid. Please try again.'
  end

  def player_setup(num)
    temp_name = pick_name(num)
    temp_color = players.empty? ? pick_color : remaining_color
    Player.new(temp_name, temp_color)
  end

  def pick_name(num)
    puts "Please enter a name for player #{num + 1}"
    gets.chomp
  end

  def pick_color
    puts 'Would you like to be Red or White? (type R or W)'
    arr = %W[R W]
    picker_loop(arr)
  end

  def remaining_color
    players[0].color == 'W' ? 'R' : 'W'
  end

  def round(players, board = Board.new)
    loop do
      player = first_player(players)
      col = pick_col(player, board).to_i
      board.drop(col, player)
      board.render_array
      break if win_draw_check(board, player)

      update_first_player
    end
    # this is where play again option would go
  end

  def win_draw_check(board, player)
    if check_winner(board)
      win_message(player)
      return true
    elsif check_draw(board)
      draw_message
      return true
    end
    false
  end

  def first_player(arr)
    arr.find { |plyr| plyr.first == true}
  end

  def pick_col(player, board)
    puts "#{player.name} please select a number to place your piece"
    arr = ('1'..'7').to_a
    col_picker_loop(arr, board)
  end

  def col_picker_loop(arr, board)
    loop do
      elmnt = verify_input(player_input, arr)
      return elmnt if arr.include?(elmnt) && collumn_not_full?(elmnt, board)

      puts error_msg_invalid_input
    end
  end

  def collumn_not_full?(col, board)
    board.array[0][col.to_i - 1] == board.empty
  end

  def check_winner(board)
    arr = board.array
    win_check_rows(arr) || win_check_cols(arr) || win_check_rgtagls(arr) || win_check_lftagls(arr)
  end

  def win_check_rows(array, x = 0, y = 0, queue = Array.new(4))
    until array[x].nil?
      queue << array[x][y]
      queue.shift()
      return true if queue.all?("\e[31m\u25CF\e[0m") || queue.all?("\e[37m\u25CF\e[0m")

      y += 1
      next unless array[x][y].nil?

      x += 1 
      y = 0 
      queue = Array.new(4)
    end
  end

  def win_check_cols(array, x = 0, y = 0, queue = Array.new(4))
    until array[y].nil?
      queue << array[x][y]
      queue.shift
      return true if queue.all?("\e[31m\u25CF\e[0m") || queue.all?("\e[37m\u25CF\e[0m")

      x += 1
      next unless array[x].nil?

      y += 1
      x = 0 
      queue = Array.new(4)
    end
  end

  def win_check_rgtagls(array)
    right_first_half(array) || right_second_half(array)
  end

  def right_first_half(array, start = [(array.length - 1), 0])
    until start == [0, 0]
      return true if increment_queue_right(array, start[0], start[1])

      start[0] -= 1
    end
  end

  def right_second_half(array, start = [0, 0])
    until array[start[0]][start[1]].nil?
      return true if increment_queue_right(array, start[0], start[1])

      start[1] += 1
    end
  end

  def increment_queue_right(array, x, y, queue = Array.new(4))
    until array[x].nil? || array[x][y].nil?
      queue << array[x][y]
      queue.shift
      # puts "#{x}, #{y}, #{queue}"
      return true if queue.all?("\e[31m\u25CF\e[0m") || queue.all?("\e[37m\u25CF\e[0m")

      x += 1
      y += 1
    end
  end

  def win_check_lftagls(board)
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
      return true if queue.all?("\e[31m\u25CF\e[0m") || queue.all?("\e[37m\u25CF\e[0m")

      x += 1
      y -= 1
      break if y.negative?
    end
  end

  def update_first_player
    players.map do |plyr|
      plyr.first = plyr.first != true
      plyr
    end
  end

  def win_message(player)
    puts "Congratulations #{player.name} you've won!"
  end

  def check_draw(board)
    board.array.flatten.none?("\u25CB")
  end

  def draw_message
    puts "Game Over!  It's a draw."
  end
end
