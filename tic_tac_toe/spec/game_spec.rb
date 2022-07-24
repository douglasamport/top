require './lib/game.rb'

describe Game do
  describe '#initialize' do
    # no tests needed 
  end
  describe '#game_setup'do
    #script method -> test the methods inside
  end
  describe '#welcome'do
    #puts method -> no tests needed
  end
  
  describe '#player_setup_loop' do
    
  end

  describe '#player_setup' do

    subject(:game) { described_class.new }
    before  do
      allow(game).to receive(:gets).and_return('tim')
      
     end

    context 'if used_symbols array'do
      
      before do
        allow(game).to receive(:player_pick_symbol).and_return('X')
      end

      it 'returns players choice' do
        symbol = game.player_setup.symbol
        expect(symbol).to eq('X')
      end
    end

    context 'if used_symbol is not empty' do
  
      it 'returns X if O is in the array' do
        game.used_symbols << 'X'
        symbol = game.player_setup.symbol
        expect(symbol).to eq('O')
      end
      it 'returns O if X is in the array'do
        game.used_symbols << 'O'
        symbol = game.player_setup.symbol
        expect(symbol).to eq('X')
      end
    end
  end

  describe '#player_pick_symbol'do
    subject(:game) { described_class.new }
    let(:player_pick) { game.player_pick_symbol("tim")}
    
    context 'when symbol is valid' do
      before do
        allow(game).to receive(:gets).and_return('X')
        end
        
      it 'returns symbol when symbol is valid' do
        expect(player_pick).to eq('X')
      end
    end

    context 'when symbol is in-valid once' do
      
      before do
        msg = "Welcome tim. Would you like to be X's or O's (Please enter x or o. X's go first)"
        allow(game).to receive(:gets).and_return('f', 'X')
        allow(game).to receive(:puts).with(msg)
      end
        
      it 'returns message once' do
        name = 'tim'
        invalid = 'That selection is invalid.  Please select the letter X or O.'
        expect(game).to receive(:puts).with(invalid).once
        game.player_pick_symbol(name)
      end
    end
    context 'when symbol is in-valid twice' do 
      before do
        msg = "Welcome tim. Would you like to be X's or O's (Please enter x or o. X's go first)"
        allow(game).to receive(:gets).and_return('p', 'l', 'X')
        allow(game).to receive(:puts).with(msg)
      end

      it 'returns message twice' do
        name = 'tim'
        invalid = 'That selection is invalid.  Please select the letter X or O.'
        expect(game).to receive(:puts).with(invalid).twice
        game.player_pick_symbol(name)
      end
    end
  end

  describe '#rules' do
    #puts method -> no tests needed
  end

  describe '#print_stats' do
    #puts method -> no tests needed
  end

  describe '#round' do
    #looping method -> test the methods inside
  end

  describe '#determine_first_player' do
    subject(:game) { described_class.new }
    

    context "if one players symbol is X" do
      let(:player_one) { double('player_o', name: 'tim', symbol: 'X', first: true)}
      let(:player_two) { double('player_t', name: 'jim', symbol: 'O', first: false)}

      it "returns player whose symbol is X" do
        
        arr = [player_one, player_two]
        method = game.determine_first_player(arr)
        expect(method).to eq(player_one)
      end
    end

    context 'if players first value swaps' do
      let(:player_one) { double('player_o', name: 'tim', symbol: 'X', first: false)}
      let(:player_two) { double('player_t', name: 'jim', symbol: 'O', first: true)}

      it "returns player whose symbol is O" do
        arr = [player_one, player_two]
        method = game.determine_first_player(arr)
        expect(method).to eq(player_two)
      end
    end
  end

  describe '#make_selection' do
    subject(:game) { described_class.new }
    let(:selection) { game.make_selection}

    context 'when player selects a valid selection' do
      before do
        allow(game).to receive(:gets).and_return('1')
      end
      
      it 'returns selection' do
        expect(selection).to eq(1)
      end
    end
    context 'when player selects an invalid selection once' do
      before do
        allow(game).to receive(:gets).and_return('a', '1')
      end
      it 'returns a valid selection' do
        
        expect(selection).to eq(1)
      end
    end
    context 'when player selects an invalid selection twice' do
      before do
        allow(game).to receive(:gets).and_return('a','10', '3')
      end
      it 'returns a valid selection' do
        expect(selection).to eq(3)
      end
    end
    context 'when player selects number thats been played once' do
      before do
        allow(game).to receive(:gets).and_return('1', '3')
      end
      it 'returns a valid selection' do
        game.played_arr << 1
        expect(selection).to eq(3)
      end
    end
  end

  describe '#err_invalid_selection' do
    # puts method -> no tests needed
  end

  describe 'err_already_played' do
    # puts method -> no tests needed
  end

  describe '#update_board' do
    #looping method -> test the methods inside
  end

  describe '#update_board_array'do
    subject(:game) { described_class.new }
    let(:player) { instance_double(Player, symbol: 'X')}

    context 'when player choses a number' do

      it 'replaces num in board array with X'do
        arr = [1, 2, 3, 4, 'X', 6, 7, 8, 9]
        game.update_board_array(5, player)
        expect(game.board_arr).to eq(arr)
      end

      it 'played_arr includes num' do
        num = 5
        game.update_board_array(num, player)
        expect(game.played_arr).to include(num)
      end
    end
  end
  
  describe '#update_board_display' do
    #puts method -> no test required
  end

  describe '#update_scenerios' do
    #returns instance variable
    subject(:game) { described_class.new }
    it 'returns array' do
      arr = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9],[3, 5, 7]]
      expect(game.update_scenerios).to eq(arr)
    end
  end

  describe '#check_game_end' do
    subject(:game) { described_class.new }
    let(:player_one) { instance_double(Player, name: 'tim', first: true, symbol: 'X')}


    context 'when one of the conditions for winning is met'do
      
      it 'prints victory msg when array 1 of 8 is all symbol' do
        msg = "#{player_one.name} is the Winner!"
        game.board_arr = ['X', 'X', 'X', 4, 5, 6, 7, 8, 9]
        game.update_scenerios
        expect(game).to receive(:puts).with(msg)
        game.check_game_end(player_one)
      end
      
      it 'prints victory msg when array 2 of 8 is all symbol' do
        msg = "#{player_one.name} is the Winner!"
        game.board_arr = [1, 2, 3,'X', 'X', 'X', 7, 8, 9]
        game.update_scenerios
        expect(game).to receive(:puts).with(msg)
        game.check_game_end(player_one)
      end

      it 'prints victory msg when array 3 of 8 is all symbol' do
        msg = "#{player_one.name} is the Winner!"
        game.board_arr = [1, 2, 3, 4, 5, 6, 'X', 'X', 'X']
        game.update_scenerios
        expect(game).to receive(:puts).with(msg)
        game.check_game_end(player_one)
      end

      it 'prints victory msg when array 4 of 8 is all symbol' do
        msg = "#{player_one.name} is the Winner!"
        game.board_arr = ['X', 2, 3, 'X', 5, 6, 'X', 8, 9]
        game.update_scenerios
        expect(game).to receive(:puts).with(msg)
        game.check_game_end(player_one)
      end

      it 'prints victory msg when array 5 of 8 is all symbol' do
        msg = "#{player_one.name} is the Winner!"
        game.board_arr = [1, 'X', 3, 4, 'X', 6, 7, 'X', 9]
        game.update_scenerios
        expect(game).to receive(:puts).with(msg)
        game.check_game_end(player_one)
      end

      it 'prints victory msg when array 6 of 8 is all symbol' do
        msg = "#{player_one.name} is the Winner!"
        game.board_arr = [1, 2, 'X', 4, 5, 'X', 7, 8, 'X']
        game.update_scenerios
        expect(game).to receive(:puts).with(msg)
        game.check_game_end(player_one)
      end

      it 'prints victory msg when array 7 of 8 is all symbol' do
        msg = "#{player_one.name} is the Winner!"
        game.board_arr = ['X', 2, 3, 4, 'X', 6, 7, 8, 'X']
        game.update_scenerios
        expect(game).to receive(:puts).with(msg)
        game.check_game_end(player_one)
      end

      it 'prints victory msg when array 8 of 8 is all symbol' do
        msg = "#{player_one.name} is the Winner!"
        game.board_arr = [1, 2, 'X', 4, 'X', 6, 'X', 8, 9]
        game.update_scenerios
        expect(game).to receive(:puts).with(msg)
        game.check_game_end(player_one)
      end
    end
    
    context 'when none of the conditions are met' do
      it 'prints tie message' do
        msg = 'Game over!  It\'s a tie.'
        game.played_arr = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        expect(game).to receive(:puts).with(msg)
        game.check_game_end(player_one)
      end
      
    end
  end

  describe '#update_first_player' do
    subject(:game) { described_class.new }
    let(:player_one) { instance_double(Player, name: 'tim', first: true)}
    let(:player_two) { instance_double(Player, name: 'jim', first: false)}
    
    
    context 'when player one is true and player two is false' do
      
      before do
        
        allow(player_one).to receive(:first=).with(false)
        allow(player_two).to receive(:first=).with(true)
        
      end

      it 'makes player one to false' do
        game.players << player_one
        game.players << player_two
        expect(player_one).to receive(:first=).with(false)
        game.update_first_player
      end

      it 'makes player two true' do
        game.players << player_one
        game.players << player_two
        expect(player_two).to receive(:first=).with(true)
        game.update_first_player
      end
    end
    

  end
  
end
