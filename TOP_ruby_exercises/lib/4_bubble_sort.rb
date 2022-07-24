
def bubble_sort(arr)
  x = arr.rindex(arr.min)
  x.times do 
    i = 0
    while i < arr.length - 1 do
      if (arr[i] <=> arr[i + 1]) == 1
        arr[i], arr[i+1] = arr[i+1], arr[i]
      end
      i += 1
      arr
    end
  end
  arr
end

set_one = [4, 3, 78, 2, 0, 2]
set_two = [61, 58, 53, 53, 30, 48, 23, 23, 40, 24]
set_three = [38, 34, 66, 98, 27, 54, 43, 74, 58, 10]
set_four = [1, 5, 40, 49, 53, 57, 78, 89, 94, 95]
set_five = [82, 20, 53, 90, 9, 73, 37, 88, 50, 94]
test_1 = [1, 2, 3, 4, 5]
test_2 = [2, 1, 2, 1, 3]
test_3 = [5, 4, 3, 2, 1]

p bubble_sort(test_1)
p bubble_sort(test_2)
p bubble_sort(test_3)
p bubble_sort(set_one)
p bubble_sort(set_two)
p bubble_sort(set_three)
p bubble_sort(set_four)
p bubble_sort(set_five)