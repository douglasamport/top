require 'yaml'

class Main

  attr_accessor :first, :second, :third

  def initialize(second, third)
    @first = 'first'
    @second = second
    @third = third
    save()
  end

  def save
    class_file = YAML.dump(self)
    t = Time.now
    id = t.strftime('%d-%m-%H-%M-%S')
    Dir.mkdir('saved_game') unless Dir.exist?('saved_game')
    File.open("saved_game/saved_game_one.txt", 'w') { |f| f.write(class_file)}
  end
  
  def self.load(fname)
    file = File.open(fname, 'r')
    YAML.load(file)
  end
end

class Second

  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class Third

  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
end

second = Second.new("second name")
third = Third.new("third name")

Main.new(second, third)