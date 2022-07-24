module MathHelpers
  def exponent(a, b)
    a**b
  end
end

class Calculator
  include MathHelpers
  def self.square_root(x)
    exponent(x, 0.5)
  end
end