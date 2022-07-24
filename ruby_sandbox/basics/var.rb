puts "How old are you now?"
age = gets.chomp.to_i

puts "In 10 years you will be: #{age + 10} years old"
puts "In 10 years you will be: #{age + 20} years old"
puts "In 10 years you will be: #{age + 30} years old"
puts "In 10 years you will be: #{age + 40} years old"
puts "In 10 years you will be: #{age + 50} years old"

puts "What's your first name"
first_name = gets.chomp
puts "What's your last name"
last_name = gets.chomp

10.times { 
    puts "#{first_name} #{last_name}"
}