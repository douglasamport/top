require 'open-uri'

url = 'http://ruby.bastardsbook.com/files/fundamentals/hamlet.txt'
fname = 'hamlet.txt'

open(fname, 'w') { |file| file.write(URI.open(url).read)}

# File.open(fname, 'r') do |file|
#   file.readlines.each_with_index do |line, idx|
#     puts line if idx % 42 == 41
#   end
# end





File.open(fname, 'r') do |file|
  hamlet_speaking = false
  file.readlines.each do |line|
    
    if line.match?(/^  [A-Z]/) || line.strip.empty?
      hamlet_speaking = false
    end
    hamlet_speaking = true if line.match?('Ham\.')
    
    puts line if hamlet_speaking == true
  end
end



