require_relative '../rental'
require_relative '../book'
require_relative '../person'

describe Rental do
  describe '#initialize' do
    it 'creates a rental with the specified date, book, and person' do
      date = '2023-06-29'
      book = double('book')
      person = double('person')

      expect(book).to receive(:add_rental).with(kind_of(Rental))
      expect(person).to receive(:add_rental).with(kind_of(Rental))

      rental = Rental.new(date, book, person)

      expect(rental.date).to eq(date)
      expect(rental.book).to eq(book)
      expect(rental.person).to eq(person)
    end
  end
end
