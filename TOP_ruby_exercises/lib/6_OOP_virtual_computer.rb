#add a method that updates files
#add a methond that deletes foles  
#add additional parameters to initialize or create?


class Computer
  def initialize(username, password)
    @username = username
    @password = password
    @files = {}
    @@users[username] = password
  end

  @@users = {}

  def create(filename)
    time = Time.now
    @files[filename] = time
    puts "#{@username} created file #{filename} at #{time}"
  end

  def self.get_users
    @@users
  end

  def file_list
    @files
  end

end

my_computer = Computer.new("dorthy", "rubyslippers")

puts Computer.get_users
my_computer.create("no Place like home")
my_computer.create("Yellow bricking it")
my_computer.create("Inside the Lollypop Guild")

puts my_computer.file_list
