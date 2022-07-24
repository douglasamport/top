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

  def my_map(proc = nil)
    arr = []
    if block_given? && proc.nil?
      my_each do |var|
        arr << (block.call var)
      end
    else
      my_each do |var|
        arr << (proc.call(var))
      end
    end
      arr
    end

  # my map accecpting procs
  # def my_map(block)
  #   arr = []
  #   my_each do |var|
  #     arr << (block.call(var))
  #   end
  #   arr
  # end

  # original my map.  only taking a block
  # def my_map
  #   arr = []
  #   my_each do |var|
  #     arr << (yield var)
  #   end
  #   arr
  # end
end

class Array
  include MyEnumerables
end

puts 'my_map vs map'

arr = [1, 2, 3, 4]
arr_one = ['one', 'two', 'foo', 'bar']
arr_two = ['one', 'two', 'three']
# rubocop:disable Lint/AmbiguousBlockAssociation
# my_map accecpting procs
puts 'my_map output proc'

p arr.my_map Proc.new { |num| num * 2 }
p arr_one.my_map Proc.new { |word| word + ' and-a'}
p arr_two.my_map Proc.new { |word| word.length}

# original my_map 
puts 'my_map output block'
p arr.my_map { |num| num * 2 }
p arr_one.my_map { |word| word + ' and-a'}
p arr_two.my_map { |word| word.length}

p 'enumerable output'
p arr.map { |num| num * 2 }
p arr_one.map { |word| word + ' and-a'}
p arr_two.map { |word| word.length}