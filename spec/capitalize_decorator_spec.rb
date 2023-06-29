require_relative '../capitalize_decorator'
require_relative '../base_decorator'
require_relative '../nameable'

describe CapitalizeDecorator do
  describe '#correct_name' do
    context 'when the decorated object name is shorter than or equal to 10 characters' do
      it 'returns the correct name from the decorated object without truncation' do
        nameable = double('nameable')
        decorated_nameable = CapitalizeDecorator.new(nameable)

        allow(nameable).to receive(:correct_name).and_return('John')

        result = decorated_nameable.correct_name

        expect(result).to eq('John')
      end
    end

    context 'when the decorated object name is longer than 10 characters' do
      it 'returns the correct name from the decorated object with truncation' do
        nameable = double('nameable')
        decorated_nameable = CapitalizeDecorator.new(nameable)

        allow(nameable).to receive(:correct_name).and_return('Lorem Ipsum Dolor')

        result = decorated_nameable.correct_name

        expect(result).to eq('Lorem Ipsu')
      end
    end
  end
end
