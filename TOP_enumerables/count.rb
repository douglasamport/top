# frozen_string_literal: true

module MyEnumerables #:nodoc:
  def my_each
    i = 0
    while i < self.length
      num = self[i]
      yield num
      i += 1
    end
  end

  def my_each_with_index
    i = 0
    while i < self.length
      num = self[i]
      idx = self.index(self[i])
      yield num, idx
      i += 1
    end
  end

  def my_select
    arr = []
    my_each do |var|
      arr << var if (yield var) == true
    end
    arr
  end

  def my_all?
    my_each do |var|
      next if (yield var) == true

      return false
    end
    true
  end

  def my_any?
    my_each do |var|
      next if (yield var) == false

      return true
    end
    false
  end

  def my_none?
    my_each do |var|
      next if (yield var) == false

      return false
    end
    true
  end

  def my_count
    collect = 0
    my_each do |var|
      collect += 1 if (yield var) == true
    end
    collect
  end

end


class Array
  include MyEnumerables
end



puts 'my_select vs select'



arr = [1, 2, 3, 4]
arr_one = ['one', 'two', 'foo', 'bar']
arr_two = ['one', 'two', 'three']
# rubocop:disable Lint/AmbiguousBlockAssociation

puts 'my_count output'
puts arr.my_count { |num| (num % 2).zero? }
puts arr_one.my_count { |word| word.length >= 3}
puts arr_two.my_count { |word| word.length > 3}

puts 'enumerable output'
puts arr.count { |num| (num % 2).zero? }
puts arr_one.count { |word| word.length >= 3}
puts arr_two.count { |word| word.length > 3}