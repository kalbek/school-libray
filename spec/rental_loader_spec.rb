require_relative 'spec_helper'
require_relative '../rental_loader'

RSpec.describe RentalLoader do
  describe '.load_rentals_data' do
    context 'when the rentals data file exists and is not empty' do
      let(:rentals_data) do
        [
          {
            'date' => '2023-06-01',
            'book' => { 'title' => 'Book 1', 'author' => 'Author 1' },
            'person' => { 'id' => 1, 'name' => 'John Doe', 'age' => 20, 'is_student' => true,
                          'parent_permission' => true }
          },
          {
            'date' => '2023-06-02',
            'book' => { 'title' => 'Book 2', 'author' => 'Author 2' },
            'person' => { 'id' => 2, 'name' => 'Jane Smith', 'age' => 25, 'is_student' => false,
                          'specialization' => 'Math' }
          }
        ]
      end

      before do
        allow(File).to receive(:exist?).with('rentals.json').and_return(true)
        allow(File).to receive(:empty?).with('rentals.json').and_return(false)
        allow(File).to receive(:read).with('rentals.json').and_return(rentals_data.to_json)
      end

      it 'loads the rentals data from the file' do
        rentals = RentalLoader.load_rentals_data
        rental1 = rentals[0]
        expect(rental1).to be_a(Rental)
        expect(rental1.date).to eq('2023-06-01')
        expect(rental1.book).to be_a(Book)
        expect(rental1.book.title).to eq('Book 1')
        expect(rental1.book.author).to eq('Author 1')
      end
    end

    context 'when the rentals data file does not exist or is empty' do
      before do
        allow(File).to receive(:exist?).with('rentals.json').and_return(false)
        allow(File).to receive(:empty?).with('rentals.json').and_return(true)
      end

      it 'returns an empty array' do
        rentals = RentalLoader.load_rentals_data
        expect(rentals).to eq([])
      end
    end
  end

  describe '.save_rentals_to_file' do
    it 'writes the rentals to rentals.json' do
      rentals = []
      book = Book.new('The Great Gatsby', 'F. Scott Fitzgerald')
      student = Student.new(17, 'Programming', 'John Doe', parent_permission: true, id: 1)
      rental = Rental.new('2022-06-01', book, student)
      rentals << rental

      expected_rental_data = [
        {
          'date' => rental.date,
          'book' => {
            'title' => rental.book.title,
            'author' => rental.book.author
          },
          'person' => {
            'id' => rental.person.id,
            'name' => rental.person.name,
            'age' => rental.person.age,
            'is_teacher' => false,
            'is_student' => true
          }
        }
      ]

      file_double = double('file')
      expect(File).to receive(:open).with('rentals.json', 'w').and_yield(file_double)
      expect(file_double).to receive(:write).with(expected_rental_data.to_json)

      RentalLoader.save_rentals_to_file(rentals)
    end
  end
end
