require_relative 'person'
# This class represents a student
class Student < Person
  attr_accessor :classroom

  def initialize(age, classroom, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
    classroom.add_student(self) if classroom.respond_to?(:add_student)
  end

  def play_hooky
    '¯(ツ)/¯'
  end
end
