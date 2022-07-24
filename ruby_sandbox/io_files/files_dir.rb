dir = '/home/douglasamport/the_odin_project/*/*'

file_arr = Dir.glob(dir)

dir_two = '/home/douglasamport/the_odin_project/*/*.*'

file_arr_two = Dir.glob(dir_two)

def sort_files(arr)
  nested_array = arr.each_with_object([]) do |file, nested|
    nested << [file, File.size(file)]
  end
  nested_array.sort_by! { |array| array[1]}.reverse!
  10.times { |int| puts nested_array[int]}
end

# sort_files(file_arr)

def print_files(arr)
  arr.each { |file| puts File.basename(file) }
end

# print_files(file_arr)


def count_files(arr)
  arr.reduce({}) do |hsh, file|
    sub_arr = File.basename(file).split('.')
    if sub_arr.length > 1
      ext = sub_arr[-1].to_s.upcase
      hsh[ext] ||= [0, 0]
      hsh[ext][0] += 1
      hsh[ext][1] += File.size(file)
    end
    hsh
  end
end

p counted_hash = count_files(file_arr)

def output_tab_deliniated(hash, filename)
  File.open(filename, 'w') do |f|
    hash.each do |array|
      txt = array.flatten.join("\t")
      f.puts txt
      puts txt
    end
  end
end

output_tab_deliniated(counted_hash, 'file_analysis.txt')


### File sorting and printing solution with Arrays

# def sort_by_type(arr)
#   types =  ['\.html', '\.css', '\.rb', '\.md', '\.js', '\.txt' ]
#   collector = []
#   types.each do |type| 
#     collector << arr.select { |file| file.match?(type)} 
#   end
#   collector # .each { |array| print_files(array)}
# end

# nested_sorted_files = sort_by_type(file_arr)

# def output_to_comma(arr)
#   output_array = [['Filetype', 'Count', 'Bytes']]
#   arr.each do |nested_array|
#     one = nested_array[0].split('.')[1].upcase
#     two = nested_array.length
#     three = nested_array.reduce(0) { |size, file| size + File.size(file) }
#     output_array << [one, two, three]
#   end
#   output_array.map{ |array| puts array.join("\t")}
# end

# output_to_comma(nested_sorted_files)