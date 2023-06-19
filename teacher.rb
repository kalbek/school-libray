# This class represents a teacher
class Teacher < Person
  attr_accessor :specialization

  def initialize(specialization:)
    super
    @specialization = specialization
  end
end
