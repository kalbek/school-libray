# This class represents Base Decorator.
class BaseDecorator
  def initialize(nameable)
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end
