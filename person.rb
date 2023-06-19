require 'securerandom'
# This class represents a person.
class Person
  attr_reader :id
  attr_accessor :name, :age

  def initialize(age:, name: 'Unknown', parent_permission: true)
    @id = SecureRandom.uuid
    @age = age
    @name = name
    @parent_permission = parent_permission
  end.freeze

  def can_use_services?
    of_age? || @parent_permission
  end

  private

  def of_age?
    @age >= 18
  end
end
