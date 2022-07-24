require "./lib/player.rb"

describe Player do
  
  describe "#initialize" do
    context 'when a new player with symbol X is created' do
      subject(:player) { described_class.new('tim', 'X') }

      it 'has a name' do
        name = player.name
        expect(name).to eql('tim')
      end

      it 'has a symbol' do
        symbol = player.symbol
        expect(symbol).to eq('X')
      end

      it 'goes first when symbol is X' do
        goes_first = player.instance_variable_get(:@first)
        expect(goes_first).to eq(true)
      end

      subject(:player_two) { described_class.new('tony', 'O')}

      it 'doesnt go first when symbol is O' do
        goes_first = player_two.instance_variablegame_get(:@first)
        expect(goes_first).to eq(false)
      end
    end
  end
  

  
    

end