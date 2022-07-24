# frozen_string_literal: true

require './lib/player.rb'

class Game
  attr_reader :possible_scenerios
  attr_accessor :used_symbols, :players, :played_arr, :board_arr

  def initialize
    @players = []
    @used_symbols = []
    @board_arr = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @played_arr = []
    @game_board = refresh_gameboard
    @winner = false
    @possible_scenerios = []
  end

  def game_setup
    welcome
    player_setup_loop(2)
    rules
    print_status
  end

  def welcome
    puts "Hi, Let\'s play Tic-Tac-Toe in the console."
  end

  def player_setup_loop(num)
    (num).times {players << player_setup}
  end

  def player_setup(int = players.length)
    puts "Enter a name for player #{int + 1}."
    temp_name = gets.chomp
    temp_symbol = used_symbols.empty? ? player_pick_symbol(temp_name) : used_symbols.include?('X')? 'O' : "X"
    send_symbol_to_used(temp_symbol)
    Player.new(temp_name, temp_symbol)
  end

  def player_pick_symbol (temp_name, entry = nil)
    msg = "Welcome #{temp_name}. Would you like to be X's or O's (Please enter x or o. X's go first)"
    invalid = 'That selection is invalid.  Please select the letter X or O.'
    until ['X', 'O'].include?(entry)
      puts entry.nil? ? msg : invalid
      entry = gets.chomp.upcase
    end
    entry
  end

  def send_symbol_to_used(sym)
    used_symbols << sym
  end

  def rules
    puts 'This is your game board.  Each number represents a position for Tic-Tac-Toe.'
    puts 'Choose a number to place your symbol' 
  end

  def print_status
    puts 'The current game board is'
    puts @game_board
  end

  def refresh_gameboard
    ln = '---+---+---'
    " #{@board_arr[0]} | #{@board_arr[1]} | #{@board_arr[2]} 
    #{ln}
    #{@board_arr[3]} | #{@board_arr[4]} | #{@board_arr[5]} 
    #{ln} 
    #{@board_arr[6]} | #{@board_arr[7]} | #{@board_arr[8]} ".lines.map { |str| str.strip.center(20)}.join("\n")
  end

  def round
    while @winner == false
      player = determine_first_player(players)
      puts "#{player.name} please select a number to place your #{player.symbol}"
      player_selection = make_selection
      update_board(player_selection, player)
      update_scenerios
      check_game_end(player)
      update_first_player
    end
    play_again
  end

  def determine_first_player(arr)
    arr.find { |player|
      player.first == true
    }
  end

  def make_selection
    selection = gets.chomp.to_i
    return err_invalid_selection unless (1..9).to_a.include?(selection)
    return err_allready_played if played_arr.include?(selection)
    selection
  end

  def err_invalid_selection
    puts 'Invalid selection. Please enter a number 1 thru 9'
    make_selection
  end

  def err_allready_played
    puts 'That space has already been played. Please make another selection.'
    make_selection
  end

  def update_board_array(num, player)
    played_arr << num
    board_arr[num - 1] = player.symbol
  end

  def update_board_display
    @game_board = refresh_gameboard
  end

  def update_board(num, player)
    update_board_array(num, player)
    update_board_display
    print_status
  end

  def update_scenerios
    @possible_scenerios = [[@board_arr[0], @board_arr[1], @board_arr[2]],
                           [@board_arr[3], @board_arr[4], @board_arr[5]],
                           [@board_arr[6], @board_arr[7], @board_arr[8]],
                           [@board_arr[0], @board_arr[3], @board_arr[6]],
                           [@board_arr[1], @board_arr[4], @board_arr[7]],
                           [@board_arr[2], @board_arr[5], @board_arr[8]],
                           [@board_arr[0], @board_arr[4], @board_arr[8]],
                           [@board_arr[2], @board_arr[4], @board_arr[6]]]
  end

  def check_game_end(player)
    if possible_scenerios.map{ |array| array.all? { |s| s == player.symbol } }.include?(true)
      puts "#{player.name} is the Winner!"
      @winner = true
      
    elsif played_arr.length == 9
      puts 'Game over!  It\'s a tie.'
      @winner = true 
    end
  end

  def update_first_player 
    players.map { |player| player.first = player.first != true}
  end

  def play_again
    puts 'Would you like to play again? (Y/N)'
    again = gets.chomp
    if %w[Y y].include?(again)
      reset
      print_status
      round
    else
      puts 'Thanks for playing.'
      exit
    end
  end

  def reset
    @board_arr = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @played_arr = []
    @winner = false
  end

end
