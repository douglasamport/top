
class Calculator
  def add(*args)
    args.inject(0) { |sum, num| sum + num}
  end

  def multiply(*args) 
    args.inject(1) { |sum, num| sum * num}
  end

  def divide(a, b)
    a/b
  end
end