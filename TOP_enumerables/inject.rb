# frozen_string_literal: true

require 'pry'
require 'pry-byebug'

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
    my_each { |var| collect += 1 if (yield var) == true }
    collect
  end

  def my_map
    arr = []
    my_each { |var| arr << (yield var) }
    arr
  end

  def my_inject(accumulator = nil, operation = nil, &block)
    if accumulator == nil && operation == nil && block == nil
      raise ArgumentError "you must provide an operation or a block"
    end
    
    if operation && block
      raise ArgumentError "you must provide either an operatorion symbol or a block, not both"
    end

    if operation.nil? && block.nil?
      operation = accumulator
      accumulator = nil
    end

    block = case operation
    when Symbol
      lambda { |acc, value| acc.send(operation, value)}
    when nil
      block
    else
      raise ArgumentError "the operation provided must be a symbol"
    end

    if accumulator.nil?
      ignore_first = true
      accumulator = first
    end

    index = 0

    my_each do |var|
      unless ignore_first && index.zero?
        accumulator = block.call(accumulator, var)
      end
      index += 1
    end
    accumulator
  end

  def first
    found = nil
    each do |element|
      found = element
      break
    end
    found
  end

  
end

class Array
  include MyEnumerables
end

def multiply_els(arr)
 arr.my_inject(:*)
end


puts 'my_inject vs inject'

arr = [7, 2, 3, 4]
arr_two = [6, 8, 10, 12]
# rubocop:disable Lint/AmbiguousBlockAssociation


puts 'my_inject output'
multiply_els(arr_two)

p arr.my_inject(1) { |obj, var| obj + var }
p arr.my_inject(1) { |obj, var| obj * var }
p arr.my_inject(1, :+)
p arr.my_inject(1, :*)
p arr.my_inject() { |obj, var| obj + var }
p arr.my_inject() { |obj, var| obj * var }

p arr.my_inject(:+)
p arr.my_inject(:*)

p 'enumerable output'
p arr.inject(1) { |obj, var| obj + var }
p arr.inject(1) { |obj, var| obj * var }
p arr.inject(1, :+)
p arr.inject(1, :*)
p arr.inject() { |obj, var| obj + var }
p arr.inject() { |obj, var| obj * var }
p arr.inject(:+)
p arr.inject(:*)


# def my_inject(*a)
#   if block_given?
#     arr = []
#     my_each_with_index do |var, idx|
#       if a.empty? && idx.zero?
#         arr << var
#         next
#       elsif !a.empty? && idx.zero?
#         obj = a[0]
#       else 
#         obj = arr[-1]
#       end
#      # binding.pry
#       arr << (yield var, obj)
#     end
#     arr[-1]
#   else
#     sum = 0
#     my_each_with_index do |var, idx|
#       if a.length > 1
#         sum = a[0]
#       else
#         sum = var
#         binding.pry
#         next
#       end
#       sum = sum.method var
#     end
#   end
# end