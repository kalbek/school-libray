# This class represents Trimmer Decorator
require_relative 'base_decorator'
class TrimmerDecorator < BaseDecorator
  def initialize(nameable)
    super
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name.strip
  end
end
