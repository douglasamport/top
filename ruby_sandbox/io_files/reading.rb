f = File.open('super.txt', 'w')
f.puts "Abha is a super Attractive lady"
f.close

File.open('super.txt', 'a') { |f| f.puts 'She really really is Sexy'}