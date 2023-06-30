require_relative '../base_decorator'
require_relative '../nameable'
describe BaseDecorator do
  describe '#correct_name' do
    it 'returns the correct name from the decorated object' do
      nameable = double('nameable')
      decorated_nameable = BaseDecorator.new(nameable)

      expect(nameable).to receive(:correct_name).and_return('John Doe')

      result = decorated_nameable.correct_name

      expect(result).to eq('John Doe')
    end
  end
end
