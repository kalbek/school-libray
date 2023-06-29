require_relative '../nameable'

class TestNameable < Nameable
  def correct_name
    'Test Name'
  end
end

RSpec.describe Nameable do
  let(:nameable) { TestNameable.new }

  describe '#correct_name' do
    it 'returns the correct name' do
      expect(nameable.correct_name).to eq('Test Name')
    end
  end
end
