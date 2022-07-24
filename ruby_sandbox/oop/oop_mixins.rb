# Create your module here!
module MartialArts
  def swordsman
    puts "I'm a swordsman"
  end
   def barehand
    puts "I'm a peacefull warrior"
  end
end

module MentalAttacks
  def stare
    puts "I kill with my mind"
  end
end



class Ninja
  include MartialArts
  def initialize(clan)
    @clan = clan
  end
end

class Samurai
  include MartialArts
  def initialize(shogun)
    @shogun = shogun
  end
end

class Monk
  include MartialArts
  include MentalAttacks
  def initialize(temple)
    @temple = temple
  end 
end

yojimbo = Samurai.new("ronin")
yojimbo.swordsman


monkey_prince = Monk.new("iron_fist")
monkey_prince.barehand
monkey_prince.stare