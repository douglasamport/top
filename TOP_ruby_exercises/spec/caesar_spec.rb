require 'spec_helper'
require './lib/caesar'

describe '.caesar_cipher' do
  subject { caesar_cipher(string, shift) }
  context "returns string" do
    let(:string) { 'abcd'}
    let(:shift) { 4 }
    it { should be_a(String) }
  end

  context 'shifts by amount' do
    let(:shift) { 4 }
    context 'string is all lowercase' do
      let(:string) { 'abcd'}
      it 'returns shifted string' do
        should eql('efgh')
      end
    end
    context 'string includes uppercase' do
      let(:string) { 'aBCd'}
      it 'returns shifted string' do
        should eql('eFGh')
      end
    end

    context 'shifts only letters'do
      let(:string) { 'aB!1Cd@@2hijk2l$4'}
      it 'ignores non-letters' do
        should eql('eF!1Gh@@2lmno2p$4')
      end
    end
  end

  context 'shifts by large amount' do
    let(:shift) { 600 }
    let(:string) { 'abcdefghijklmnopqrstuvwxyz !!! ABCDEFGHIJKLMNOPQRSTUVWXYZ'}
    it 'returns shifted string' do
      should eql('cdefghijklmnopqrstuvwxyzab !!! CDEFGHIJKLMNOPQRSTUVWXYZAB')
    end
  end
    
end
