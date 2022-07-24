require 'yaml'

class Ogre
  attr_accessor :strength, :speed, :smell
  def initialize(strength, speed, smell)
    @strength = strength
    @speed = speed
    @smell = smell
  end
end

class Dragon
  attr_accessor :strength, :speed, :color
  def initialize(strength, speed, color)
    @strength = strength
    @speed = speed
    @color = color
  end
end

class Fairy
  attr_accessor :strength, :speed, :intelligence
  def initialize(intelligence)
    @strength = 1
    @speed = 42
    @intelligence = intelligence
  end
end

public

def save_game(char_hash)
	YAML.dump(char_hash)
end

def load_game(string)
  YAML.load(string)
end

def build_characters
  hash = {dragons: [], fairies: [], orges: []}
  6.times do
  x = rand(1..3)
    case x
      when 1
        hash[:fairies] << Fairy.new(rand(20..40))
      when 2
        hash[:dragons] << Dragon.new(rand(100..200), rand(90..160), "red")
      else 3
        hash[:orges] << Ogre.new(rand(100..200), rand(90..160), "bad")
    end
  end
  hash
  end


# characters = build_characters

# o = save_game(characters)

# File.open('saved-game.txt', 'w+') { |f| f.puts o }

characters_loaded = File.open('saved-game.txt', 'r') do |f| 
  i = f.read  
  load_game(i)
end
 
p characters_loaded
