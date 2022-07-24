
def caesar_cipher(string, shift)
    string.chars.map { |chr| chr.ord}
    .map do |num|
      if num >=65 && num <=90
        (((num - 65) + shift) % 26) + 65
      elsif num >=97 && num <=122
        (((num - 97) + shift) % 26) + 97
      else
        num 
      end
    end
    .map { |num| num.chr}.join("")
end

p caesar_cipher("abcdefghijklmnopqrstuvwxyz !!! ABCDEFGHIJKLMNOPQRSTUVWXYZ", 600)


