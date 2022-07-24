require './lib/game'
require './lib/player'



describe Game do

  describe '#initialize' do
    
    subject(:new_game) { described_class.new(player_one, player_two) }
    let(:player_one) { instance_double(Player, name: 'tim', symbol: 'X')}
    let(:player_two) { instance_double(Player, name: 'cindy', symbol: 'O') }

    context 'when new game is started' do
      
      before do
        # allow(new_game).to receive(:half_round).with(player_one)
        # allow(:half_round).to receive(player_one)
        # allow(subject).to recieve(:start_up)
        allow(:make_selection).to receive(:chomp).and_return(1)
      end
      
      it 'takes a number' do
        msg = 'This is your game board.  Each number represents a position for Tic-Tac-Toe.'
        expect(new_game).to receive(:round)
        new_game.start_up
      end

      xit 'should send #round' do
        
      end
    end
     
  end
end