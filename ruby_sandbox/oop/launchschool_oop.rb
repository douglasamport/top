# class Animal
#   def speak
#     "hello"
#   end
# end

# class BadCat < Animal
# end


# class GoodDog < Animal
#   attr_accessor :name, :height, :weight, :age
#   @@number_of_dogs = 0
#   DOG_YEARS = 7
#   def initialize(n, a, h, w)
#     self.name = n
#     self.age = a 
#     self.height = h
#     self.weight = w
#     @@number_of_dogs += 1
#   end

#   def speak
#     super + " #{@name} says arf!"
#   end

#   def change_info(n, h, w)
#     self.name = n
#     self.height = h
#     self.weight = w
#   end

#   def info
#     "#{self.name} weights #{self.weight} and is #{self.height} tall."
#   end

#   def to_s
#     "This dog's name is #{name} and it is #{age} in dog years."
#   end

#   def self.total_number_of_dogs
#     @@number_of_dogs
#   end

#   def public_disclosure
#     "#{self.name} in human years is #{self.human_years}"
#   end

#   private

#   def human_years
#     age * DOG_YEARS
#   end



# end


# sparky = GoodDog.new("Sparky", 5, "12 inches", "10 lbs")
# fido = GoodDog.new("Fido", 12, "14 inches", '16 lbs')
# paws = BadCat.new

# p sparky.public_disclosure


# # p GoodDog.total_number_of_dogs
# # puts sparky.age
# # puts sparky
# # p sparky.info

# # sparky.change_info("Spartacus", "24 inches", '45 lbs')
# # p sparky.info


#############

module Haulable
  def pulling_boat
    "We're on a boat Yo!"
  end
end

class Vehicle
  attr_accessor :color, :current_speed, :running
  attr_reader :year, :model
  @@number_of_vehicles = 0
  def initialize(y, c, m)
    @year = y
    self.color = c
    @model = m
    self.current_speed = 0
    self.running = false
    @@number_of_vehicles += 1
  end

  def accelerate(mph)
    self.current_speed += mph
    puts "You accelerate #{mph} mph"
  end

  def brake(mph)
    self.current_speed -= mph
    puts "You decelerate #{mph} mph"
  end

  def check_current_speed
    puts "You are now going #{self.current_speed} mph"
  end

  def ignition
    self.running = !self.running
    if self.running
      puts "VrooOOOm VrooOOM, ready to go!"
    else 
      puts "Time to put the toys away!"
    end
  end

  def self.gas_mileage(gallons, miles)
    puts "#{gallons/miles} miles per gallon of gas"
  end

  def self.print_number_of_vehicles
    @@number_of_vehicles
  end

  def age
    "Your #{self.year} #{self.model} is #{years_old} years old "
  end

  private

  def years_old
    t = Time.now
    t.year - self.year
  end

end

class MyCar < Vehicle
  DOORS = 4
  def initialize(y, c, m)
    super(y, c, m)
  end
  def spray_paint(new_color)
    self.color = new_color
    puts "Your car is now #{self.color}"
  end
  def to_s
    "My Car is a #{color}, #{year}, #{model}"
  end
end

class MyTruck < Vehicle
  DOORS = 2
  include Haulable
  def initialize(y, c, m)
    super(y, c, m)
  end
end


dodge = MyTruck.new(2020, "black", "Silverado")
porshe = MyCar.new(2009, "red", "Turbo S")
p Time.new


p dodge.age
p porshe.age


# puts porshe
# porshe.ignition
# p dodge.pulling_boat
# puts MyTruck.ancestors
# puts MyCar.ancestors

# porshe.accelerate(60)
# porshe.check_current_speed
# porshe.brake(30)
# porshe.check_current_speed
# porshe.brake(30)
# porshe.check_current_speed
# porshe.ignition



