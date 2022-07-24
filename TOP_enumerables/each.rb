puts 'my_each vs each'

module MyEnumerables
  def my_each
    i = 0
    while i < length
      num = self[i]
      yield num
      i += 1
    end
  end
end

class Array
  include MyEnumerables
end


arr = [1, 2, 3, 4]

puts 'my_each output'
arr.my_each { |num| puts num }

puts 'enumerable output'
arr.each { |num| puts num}
