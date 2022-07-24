

class Student
  attr_accessor :name
  def initialize(name, grade)
    self.name = name
    @grade = grade
  end

  def
    better_grade_than(person)
    grade > person.grade
  end

  protected
  
  def grade 
    @grade
  end
  
end


# joe = Student.new("Joe", 99)
# bob = Student.new("Bob", 89)
# vic_msg = "well done!"
# los_msg = "nice try sucker!"
# puts vic_msg if joe.better_grade_than(bob)
# puts bob.grade