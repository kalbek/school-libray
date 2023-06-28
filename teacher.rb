# This class represents a teacher
class Teacher < Person
  attr_accessor :specialization

  def initialize(age, name = 'Unknown', parent_permission: true, specialization: 'Unknown', id: nil)
    super(age, name, parent_permission: parent_permission, id: id)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
