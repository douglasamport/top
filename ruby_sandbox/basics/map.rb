ark = ['cat', 'dog', 'pig', 'goat']

def reverse_each_second(array)
    array.each_with_index.map do |animal, idx| 
        if idx % 2 != 0 
            animal.reverse.upcase
        else
            animal
        end
    end
end

bark = reverse_each_second(ark)
p bark
p ark


xml["statuses"].select { |status| status[retweet_count].to_i > 10 }
