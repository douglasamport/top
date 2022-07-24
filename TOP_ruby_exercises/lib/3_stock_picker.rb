
def stock_picker(array)
  array.map.with_index do |buy, idx|
    array.drop(idx+1).each_with_object([0, 0, 0]) do | (sel), arr|
      if (sel - buy) > arr[0]
        arr[0..2] = [sel - buy, idx, array.find_index(sel)]
      end
    end
  end
  .max_by { |arr| arr[0]}.drop(1)                                           
end

price_range_one = [17,3,6,9,15,8,6,1,10]
price_range_two = [47, 31, 22, 3, 9, 49, 30, 33, 35, 12, 48, 20, 50, 39, 26, 8, 11, 21, 23, 42]
price_range_three = [33, 25, 6, 8, 42, 9, 48, 36, 40, 31, 34, 38, 44, 21, 20, 4, 15, 17, 5, 23]
price_range_four = [20, 16, 21, 15, 31, 37, 11, 6, 10, 33, 22, 12, 24, 14, 34, 42, 18, 8, 41, 40]
price_range_five = [13, 37, 7, 46, 15, 10, 17, 36, 1, 24, 35, 16, 39, 19, 40, 30, 50, 11, 47, 5]
price_range_six = [20, 18, 15, 12, 11, 10, 9, 8, 7, 6, 5, 4]

p stock_picker(price_range_one)   # should return [1, 4]
p stock_picker(price_range_two)   # should return [3, 12]
p stock_picker(price_range_three) # should return [2, 6]
p stock_picker(price_range_four)  # should return [7, 15]
p stock_picker(price_range_five)  # should return [8, 16]
p stock_picker(price_range_six)   # should return [0, 0]
