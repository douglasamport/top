$LOAD_PATH << File.join('users', 'douglasamport', 'ruby_testing/lib/dog.rb')

require 'rspec'
require 'dog.rb'

RSpec.describe Dog do
  # subject { Dog.new }
  describe '#bark' do
    it 'returns the string "Woof!"' do
      expect(subject.bark).to eql('Woof!')
    end
  end

  describe '#feed'do
    context 'when the dog is hungry' do
      subject { described_class.new(hunger_level: 7) }
      it 'is no longer hungry' do
        subject.feed 
        expect(subject).to_not be_hungry
      end
    end
  end

  describe '#hungry?' do
    context 'hunger_level is more than 5' do
      subject { described_class.new(hunger_level: 7) }
      it 'returns true' do
        expect(subject).to be_hungry
      end
    end

    context 'hunger_level is 5 or less' do
      subject { described_class.new(hunger_level: 5) }
      it 'returns false' do
        expect(subject).to_not be_hungry
      end
    end 
  end
end