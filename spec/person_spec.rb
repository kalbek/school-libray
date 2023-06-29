require_relative '../nameable'
require_relative '../person' # Assuming the class is defined in a separate file named 'person.rb'

RSpec.describe Person do
  let(:person) { Person.new(20, 'John Doe') } # Create a test instance of Person

  describe '#can_use_services?' do
    context 'when the person is of age' do
      it 'returns true' do
        expect(person.can_use_services?).to be(true)
      end
    end

    context 'when the person is not of age but has parent permission' do
      let(:person) { Person.new(16, 'Jane Doe', parent_permission: true) }

      it 'returns true' do
        expect(person.can_use_services?).to be(true)
      end
    end

    context 'when the person is not of age and does not have parent permission' do
      let(:person) { Person.new(16, 'Jake Doe', parent_permission: false) }

      it 'returns false' do
        expect(person.can_use_services?).to be(false)
      end
    end
  end

  describe '#correct_name' do
    it 'returns the person\'s name' do
      expect(person.correct_name).to eq('John Doe')
    end
  end

  describe '#add_rental' do
    let(:person) { Person.new(20, 'John Doe') }
    let(:rental) { double('rental') }

    it 'adds a rental to the person and sets the person as its parent' do
      expect(rental).to receive(:person=).with(person)
      person.add_rental(rental)
      expect(person.rentals).to include(rental)
    end
  end
end
