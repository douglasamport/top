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
end

class Array
  include MyEnumerables
end

arr_one = ['one', 'two', 'foo', 'bar']
arr_two = ['one', 'two', 'three']
# rubocop:disable Lint/AmbiguousBlockAssociation

puts 'my_all output'
puts arr_one.my_all? { |word| word.length == 3}
puts arr_two.my_all? { |word| word.length == 3}

puts 'enumerable output'
puts arr_one.all? { |word| word.length == 3}
puts arr_two.all? { |word| word.length == 3}
