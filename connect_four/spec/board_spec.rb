require './lib/board.rb'
require './lib/player.rb'

describe Board do
  describe '#render_array' do
    # puts array -> no tests required
  end

  describe '#drop' do
  
    context 'when player places a piece' do
      subject(:board) { described_class.new()}
      red = "\e[31m\u25CF\e[0m"
      white = "\e[37m\u25CF\e[0m"
      let(:player_one) { instance_double( Player, symbol: red)}
      let(:player_two) { instance_double( Player, symbol: white)}
      

      it 'drops to bottom row when column is empty' do
        board.drop(3, player_one)
        space = board.instance_variable_get(:@array)[5][2]
        expect(space).to eq(red)
      end 

      it 'drops to lowest available row when colum has one piece' do
        board.drop(3, player_two)
        board.drop(3, player_one)
        space = board.instance_variable_get(:@array)[4][2]
        expect(space).to eq(red)
      end

      it 'drops to lowest available row when colum has two pieces' do
        board.drop(3, player_one)
        board.drop(3, player_two)
        board.drop(3, player_one)
        space = board.instance_variable_get(:@array)[3][2]
        expect(space).to eq(red)
      end
    end
  end

  describe "#collumn_full?" do
    subject(:board) { described_class.new()}

    context 'when column is full'do
      it 'returns true' do
        full = board.collumn_full?(4)
        expect(full).to eq(false)
      end 
    end
    context 'when column is not full' do
      it 'returns false' do
        board.array[0][3] = "\e[37m\u25CF\e[0m"
        full = board.collumn_full?(4)
        expect(full).to eq(true)
      end
    end
  end

end