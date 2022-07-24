
def substrings(string, array)
  array.reduce([]) do |acc, word|
    acc << string.downcase.scan(word)
  end
  .flatten
  .each_with_object(Hash.new(0)) { |word, hash| hash[word] += 1}
end

dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

p substrings("below the OWN Low low down sun", dictionary)
p substrings("below", dictionary)
p substrings("Howdy partner, sit down! How's it going?", dictionary)
