# frozen_string_literal: true

module MyEnumerables #:nodoc:
  def my_each
    i = 0
    while i < length
      num = self[i]
      yield num
      i += 1
    end
  end

  def my_each_with_index
    i = 0
  while i < length
    num = self[i]
    idx = index(self[i])
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
end

class Array
  include MyEnumerables
end


arr = [1, 2, 3, 4]

puts 'my_select vs select'

puts 'my_select output'
# rubocop:disable Lint/AmbiguousBlockAssociation
p arr.my_select { |num| (num % 2).zero? }

puts 'enumerable output'
p arr.select { |num| (num % 2).zero? }