require_relative '../trimmer_decorator'

RSpec.describe TrimmerDecorator do
  let(:nameable) { double('nameable') }
  subject(:decorated_nameable) { described_class.new(nameable) }

  describe '#correct_name' do
    context 'when the decorated object name has leading or trailing whitespace' do
      it 'returns the correct name from the decorated object without whitespace' do
        allow(nameable).to receive(:correct_name).and_return('  John Doe  ')
        expect(decorated_nameable.correct_name).to eq('John Doe')
      end
    end

    context 'when the decorated object name does not have leading or trailing whitespace' do
      it 'returns the correct name from the decorated object as is' do
        allow(nameable).to receive(:correct_name).and_return('John Doe')
        expect(decorated_nameable.correct_name).to eq('John Doe')
      end
    end
  end
end
