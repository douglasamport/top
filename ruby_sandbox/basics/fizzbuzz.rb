

100.downto(1) { |i|
    if i == 100 
        puts "Start using downto"
        next
    end
    if i % 3 == 0 && i % 5 == 0 
        puts "FizzBuzz"
    elsif i % 3 == 0
        puts "Fizz"
    elsif i % 5 == 0
        puts "Buzz"
    else 
        puts "#{i}"
    end
    i += 1
    
}
    