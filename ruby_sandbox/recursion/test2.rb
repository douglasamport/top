require 'pry'
require 'pry-byebug'

arr = [5, 2, 7, 11, 30, 29, 1, 5, 7, 3, 8, 7, 9, 6, 0]
arr_two = [2, 3]
arr_three = [1343, 642, 1136, 1337, 1451, 553, 1680, 1381, 1621, 137, 1932, 265, 393, 1423, 315, 1113, 996, 509, 1906, 1992, 1573, 514, 136, 806, 1211, 226, 772, 722, 1333, 1813, 837, 725, 1248, 1674, 1554, 1450, 978, 1927, 1068, 472, 1303, 816, 1777, 714, 1961, 1914, 1774, 319, 918, 687, 7]

def add_two(one, two, array = [])
  two = [] if two.nil?
  one = [] if one.nil?
# binding.pry
  if two.empty? && !one.empty?
    one.each {|n| array << n}
    one = []
  end
  if one.empty? && !two.empty?
    two.each {|n| array << n}
    two = []
  end # <<___or Here has to do with nil values
  array.compact! if array.include?(nil)

  return array if one.empty? && two.empty?

  if one[0] < two[0]
    array << one.shift
  else
    array << two.shift
  end
    
  add_two(one, two, array)
 
end

def half_arr(arr, new_array =[] )
  
  if arr.length > 2
    one, two = arr.each_slice( (arr.length/2.0).round).to_a
    return add_two(half_arr(one), half_arr(two))
  else
    one, two = arr.each_slice( (arr.length/2.0).round).to_a

   return  add_two(one, two)
  end
 
end

p half_arr(arr)
p half_arr(arr_three)