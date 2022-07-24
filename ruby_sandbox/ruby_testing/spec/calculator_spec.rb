#spec/calculator_spec.rb
require './lib/calculator'

describe Calculator do


  describe "#add" do
    it "return the sum of two numbers" do
      expect(subject.add(5, 2)).to eql(7)
    end
    it "returns the sum of more than two numbers" do
      expect(subject.add(5 ,2 ,7)).to eql(14)
    end
  end

  describe "#multiply" do
    it "returns the product of two numbers" do
      expect(subject.multiply(7, 3)).to eql(21)
    end
    it "returns the product of more than two numbers" do
      expect(subject.multiply(8, 2, 5)).to eql(80)
    end
  end

  describe "#divide" do
    it "returns the quotient of two numbers" do
      expect(subject.divide(10, 2)).to eql 5
    end
  end
end