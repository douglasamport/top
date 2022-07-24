require 'pry'
require 'pry-byebug'

arr_one = [1, 4]
arr_two = [3, 5]

def add_two(one, two, array = [])
  array << one.shift if two.empty?
  array << two.shift if one.empty? 
  array.compact! if array.include?(nil)

  return array if one.empty? && two.empty?

  array << one[0] < two[0] ? one.shift : two.shift
    
  add_two(one, two, array)
 
end
    

def arr_test(arr)
  one, *two = arr.each_slice( (arr.length/2.0).round).to_a
  p one
  p two
end

def contat_test(arr, arr2)
  arr.concat(arr2)
  p arr
  p arr2
end

contat_test(arr_one, arr_two)