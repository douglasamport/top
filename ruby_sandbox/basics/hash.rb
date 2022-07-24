
person = {name: 'bob', height: '6 ft', weight: '160 lbs', hair: 'brown'}

def keys(hash)
  puts "The Keys:"
  hash.each_key{ |k| puts k}
end

def values(hash)
  puts "The Values:"
  hash.each_value{ |v| puts v}
end

def both(hash)
  puts "The Pairs:"
  hash.each { |k, v| puts "#{k}, #{v}"}
end 


keys(person)
values(person)
both(person)



# person = {name: "Tuesday", age: 29, gender: "female"}

# towhead = {hair: "blond", eyes: "blue"}

# def merge_new(hashA, hashB)
#   hashC = hashA.merge(hashB)
#   puts hashA
#   puts hashC
# end

# def merge_same(hashA, hashB)
#   hashA.merge!(hashB)
#   puts hashA
# end

# merge_new(person, towhead)

# merge_same(person, towhead)







# def greeting(name, options = {})
#     if options.empty?
#         puts "Hi, my name is #{name}"
#     else
#         puts "Hi, my name is #{name}. I'm #{options[:age]}" +
#         " years old and I live in #{options[:city]}."
#     end
# end

# greeting('Bob')
# greeting("Bob", age: 39, city: "New York City")


# family = {  uncles: ["bob", "joe", "steve"],
#     sisters: ["jane", "jill", "beth"],
#     brothers: ["frank","rob","david"],
#     aunts: ["mary","sally","susan"]
#   }

#  immediate = family.select{ |key, value| 
#     key == :sisters || key == :brothers 
# }

#  arr = immediate.values.flatten
 
#  p arr