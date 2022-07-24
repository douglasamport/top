require 'json'
from_fname = 'file_analysis.txt'

nested_lines_arr = File.open(from_fname, 'r') do |file| 
  file.readlines(chomp: true)
  .map{ |str| str.split("\t")}
  .map do |arr|
     [arr[0], arr[2].to_i(10)]
  end
end

# json_arr =  JSON.dump nested_lines_arr

original_index_arr = File.open('index.html', 'r+') { |f| f.readlines }

def update_arr(arr, new_line)
  arr.each_with_index do |line, idx|
    if line.match?(/^\s*data.addRows/)
      arr[idx] = "        data.addRows(#{new_line});"
    end
  end
  arr
end

new_index_arr = update_arr(original_index_arr, nested_lines_arr)

File.open('index.html', 'w') { |f| f.puts new_index_arr}
    
      

# SAVE ME FOR LATER  f.puts "        data.addRows(#{nested_lines_arr});"