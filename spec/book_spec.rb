require 'rspec'
require_relative '../book'
describe Book do
  describe '#add_rental' do
    it 'adds a rental to the book and sets the book as its parent' do
      book = Book.new('Title', 'Author')
      rental = double('rental')

      expect(rental).to receive(:book=).with(book)

      book.add_rental(rental)

      expect(book.rentals).to include(rental)
    end
  end
end
