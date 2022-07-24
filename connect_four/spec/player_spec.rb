require './lib/player.rb'

describe Player do
  describe '#initialize' do
    context 'when a player named tim with color Red is created' do

      subject(:player) {described_class.new('tim', 'R')}

      it 'has a name' do
        name = player.instance_variable_get(:@name)
        expect(name).to eq('tim')
      end

      it 'has a color' do
        color = player.instance_variable_get(:@color)
        expect(color).to eq('R')
      end

      it 'symbol is "\e[31m\u25CF\e[0m"' do
        symbol = player.instance_variable_get(:@symbol)
        expect(symbol).to eq("\e[31m\u25CF\e[0m")
      end

      it 'first is false' do
        first = player.instance_variable_get(:@first)
        expect(first).to eq(false)
      end
    end

    context 'When a player named jim with color White is created' do
      
      subject(:player) { described_class.new('jim', 'W')}
      it 'symbol is "\e[37m\u25CF\e[0m"' do
        symbol = player.instance_variable_get(:@symbol)
        expect(symbol).to eq("\e[37m\u25CF\e[0m")
      end

      it 'first is true' do
        first = player.instance_variable_get(:@first)
        expect(first).to eq(true)
      end
    end
  end
end