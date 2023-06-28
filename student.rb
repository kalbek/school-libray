require_relative 'person'
# This class represents a student
class Student < Person
  attr_accessor :classroom
  attr_reader :parent_permission, :id

  def initialize(age, classroom, name = 'Unknown', parent_permission: true, id: nil)
    super(age, name, parent_permission: parent_permission, id: id)
    @classroom = classroom
    classroom.add_student(self) if classroom.respond_to?(:add_student)
  end

  def play_hooky
    '¯(ツ)/¯'
  end
end
