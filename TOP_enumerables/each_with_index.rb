puts 'my_each_with_index vs each_with_index'

module MyEnumerables
  def my_each_with_index
    i = 0
    while i < length
      num = self[i]
      idx = index(self[i])
      yield num, idx
      i += 1
    end
  end
end

class Array
  include MyEnumerables
end


arr = [1, 2, 3, 4]

puts 'my_each_with_index output'
arr.my_each_with_index { |num, idx| puts "#{num}, #{idx}" }

puts 'enumerable output'
arr.each_with_index { |num, idx| puts "#{num}, #{idx}" }
