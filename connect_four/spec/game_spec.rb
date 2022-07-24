# frozen_string_literal: true

require './lib/game.rb'
require './lib/player.rb'
require './lib/board.rb'

describe Game do

  describe '#welcome' do
    # puts method - > no test nessicary
  end

  describe '#number_of_players' do
    # puts method -> test sub-methods
  end

  describe '#player_input' do
    # gets method - > no test nessicary
  end

  describe '#error_msg_invalid_input' do
    # gets method - > no test nessicary
  end

  describe '#verify_input' do
    subject(:game) { described_class.new }
    context 'when given valid input' do
      it 'returns argument' do
        user_input = 'R'
        arr = ['R', 'W']
        verified_input = game.verify_input(user_input, arr)
        expect(verified_input).to eq(user_input)
      end
    end

    context 'when given invalid input' do
      it 'returns nil' do
        user_input = 'j'
      arr = ['R', 'W']
      verified_input = game.verify_input(user_input, arr)
      expect(verified_input).to eq(nil)
      end
    end
  end

  describe '#picker_loop' do
    subject(:game) { described_class.new }
    msg = 'That input is invalid. Please try again.'
    
    context 'when user picks valid choice' do
      before do
        
        allow(game).to receive(:player_input).and_return('R')
      end
      it 'breaks loop and does not return error msg' do
        expect(game).not_to receive(:puts).with(msg)
        arr = ['R', 'W']
        game.picker_loop(arr)
      end
    end

    context "when user picks invalid choice once" do
      before do
        allow(game).to receive(:player_input).and_return('s', 'R')
      end
      it "returns error msg one time" do
        expect(game).to receive(:puts).with(msg).once
        arr = ['R', 'W']
        game.picker_loop(arr)
      end
    end

    context "when user picks invalid choice twice" do
      before do
        allow(game).to receive(:player_input).and_return('s','l', 'W')
      end
      it "returns error msg one time" do
        expect(game).to receive(:puts).with(msg).twice
        arr = ['R', 'W']
        game.picker_loop(arr)
      end
    end
  end

  describe "#player_setup" do
    # test sub-methods
  end

  describe "#pick_name" do
    # gets method -> no tests nessicary
  end

  describe "#pick_color" do
    # puts method -> no tests nessicary
  end

  describe '#remaining color' do

    context 'when second player is created' do
      subject(:game) { described_class.new }
      let(:player_one) { double(Player, name: 'jim', color: 'W', symbol: "\e[37m\u25CF\e[0m" , first: true)}

      it 'has opposite color' do
        game.players << player_one
        player = game.player_setup(1)
        var = player.instance_variable_get(:@color)
        expect(var).to eq('R')
      end
    end
  end

  describe '#round' do
    # looping function check sub methods
  end

  describe '#pick_col' do
    # puts function no tests nessicary
  end

  describe '#first_player' do
    subject(:game) { described_class.new }
      
    context 'when position 0 player is first' do
      let(:jim) { double(Player, name: 'jim', first: true)}
      let(:tim) { double(Player, name: 'tim', first: false)}
      it 'returns one who is first' do
        players = [jim, tim]
        plyr = game.first_player(players)
        expect(plyr).to eq(jim)
      end
    end

    context 'when position 1 player is first' do
      let(:jim) { double(Player, name: 'jim', first: false)}
      let(:tim) { double(Player, name: 'tim', first: true)}
      it 'returns one who is first' do
        players = [jim, tim]
        plyr = game.first_player(players)
        expect(plyr).to eq(tim)
      end
    end
  end

  describe '#check_winner' do
    #no tests required, check internal methods
  end

  describe '#win_check_rows' do
    subject(:game) {described_class.new}
    let(:mock_board) { instance_double(Board, array: Array.new(6) { Array.new(7, "\u25CB")}) }

    context 'when there are no winning conditions' do
      it 'returns nil' do
        array = mock_board.array
        checker = game.win_check_rows(array)
        expect(checker).to eq(nil)
      end
    end

    context 'when winning condition exists' do
      it 'returns true' do
        array = mock_board.array
        array[3] = ["\u25CB", "\u25CB", "\e[31m\u25CF\e[0m", "\e[31m\u25CF\e[0m", "\e[31m\u25CF\e[0m", "\e[31m\u25CF\e[0m", "\u25CB"]
        checker = game.win_check_rows(array)
        expect(checker).to eq(true)
      end
    end
  end

  describe '#win_check_cols' do
    subject(:game) {described_class.new}
    let(:mock_board) { instance_double(Board, array: Array.new(6) { Array.new(7, "\u25CB")}) }

    context 'when there are no winning conditions' do
      it 'returns nil' do
        array = mock_board.array
        checker = game.win_check_cols(array)
        expect(checker).to eq(nil)
      end
    end

    context 'when winning condition exists' do
      it 'returns true' do
        array = mock_board.array
        array[2][4] = "\e[37m\u25CF\e[0m"
        array[3][4] = "\e[37m\u25CF\e[0m"
        array[4][4] = "\e[37m\u25CF\e[0m"
        array[5][4] = "\e[37m\u25CF\e[0m"
        checker = game.win_check_cols(array)
        expect(checker).to eq(true)
      end
    end
  end

  describe '#win_check_rgtagls' do
    subject(:game) {described_class.new}
    let(:mock_board) { instance_double(Board, array: Array.new(6) { Array.new(7, "\u25CB")}) }
    

    context 'when there are no winning conditions' do
      it 'returns nil' do
        array = mock_board.array
        checker = game.win_check_rgtagls(array)
        expect(checker).to eq(nil)
      end
    end

    context 'when winning condition exists' do
      it 'returns true' do
        array = mock_board.array
        array[5][4] = "\e[37m\u25CF\e[0m"
        array[4][3] = "\e[37m\u25CF\e[0m"
        array[3][2] = "\e[37m\u25CF\e[0m"
        array[2][1] = "\e[37m\u25CF\e[0m"
        checker = game.win_check_rgtagls(array)
        expect(checker).to eq(true)
      end
    end
  end

  describe '#win_check_lftagls' do
    subject(:game) {described_class.new}
    let(:mock_board) { instance_double(Board, array: Array.new(6) { Array.new(7, "\u25CB")}) }

    context 'when there are no winning conditions' do
      it 'returns ni' do
        array = mock_board.array
        checker = game.win_check_lftagls(array)
        expect(checker).to eq(nil)
      end
    end

    context 'when winning condition exists' do
      it 'returns true' do
        array = mock_board.array
        array[5][1] = "\e[37m\u25CF\e[0m"
        array[4][2] = "\e[37m\u25CF\e[0m"
        array[3][3] = "\e[37m\u25CF\e[0m"
        array[2][4] = "\e[37m\u25CF\e[0m"
        checker = game.win_check_lftagls(array)
        expect(checker).to eq(true)
      end
    end
  end

  describe '#update_first_player' do
    subject(:game) { described_class.new }
    let(:player_one) { instance_double(Player, name: 'jim', first: true)}
    let(:player_two) { instance_double(Player, name: 'tim', first: false)}
    
    context 'When player one is First' do

      before do
        allow(player_one).to receive(:first=).with(false)
        allow(player_two).to receive(:first=).with(true)
      end

      it 'changes player one first to false' do
        game.players << player_one 
        game.players << player_two
        expect(player_one).to receive(:first=).with(false)
        game.update_first_player
      end

      it 'changes player two first to true' do
        game.players << player_one 
        game.players << player_two
        expect(player_two).to receive(:first=).with(true)
        game.update_first_player
      end
    end
  end

  describe '#check_draw' do
    subject(:game) { described_class.new}
    let(:full_board) { instance_double(Board, array: Array.new(6) { Array.new(7, "\e[31m\u25CF\e[0m")}) }
    let(:empty_board) { instance_double(Board, array: Array.new(6) { Array.new(7, "\u25CB")}) }

    context 'when not all the spaces are filled' do
      it 'returns nil' do
        checker = game.check_draw(empty_board)
        expect(checker).to eq(false)
      end
    end

    context 'when all the spaces are filled' do
      it 'returns true' do
        checker = game.check_draw(full_board)
        expect(checker).to eq(true)
      end
    end
  end
end
