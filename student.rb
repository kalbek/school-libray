# This class represents a student
class Student < Person
  attr_accessor :classroom

  def initialize(classroom:)
    super
    @classroom = classroom
  end
end
