

# arr = [0,1]

# 18.times do
#   arr << arr[-2] + arr[-1]
# end


# 18.times.reduce([0,1]) do |a, n|
#   a << (a[-2] + a[-1])
# end

data_arr = [['dog', 'Fido'], ['cat', 'Whiskers'], ['fish', 'Fluffy']]

def array_to_hash(array)
  array.reduce({}) do |hash, pair|
    hash[pair[0].to_sym] = pair[1]
    hash
  end
end

data_hash =  array_to_hash(data_arr)


def hash_to_array(hash)
  hash.reduce([]) do |arr, idx|
    arr << [idx[1], idx[0]]
  end
end