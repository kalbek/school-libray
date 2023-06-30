require_relative '../book_loader'
require_relative '../book'
require 'json'

RSpec.describe BookLoader do
  let(:books) { [] }

  describe '.save_books_to_file' do
    context 'when books are provided' do
      let(:book1) { Book.new('Book 1', 'Author 1') }
      let(:book2) { Book.new('Book 2', 'Author 2') }
      let(:books) { [book1, book2] }

      it 'saves books data to a file' do
        expect(File).to receive(:write).with('books.json', JSON.generate([
                                                                           { 'title' => 'Book 1',
                                                                             'author' => 'Author 1' },
                                                                           { 'title' => 'Book 2',
                                                                             'author' => 'Author 2' }
                                                                         ]))

        BookLoader.save_books_to_file(books)
      end
    end
  end

  describe '.load_books_data' do
    context 'when the books file exists and is not empty' do
      before do
        allow(File).to receive(:exist?).with('books.json').and_return(true)
        allow(File).to receive(:empty?).with('books.json').and_return(false)
        allow(File).to receive(:read).with('books.json').and_return('[
          { "title": "Book 1", "author": "Author 1" },
          { "title": "Book 2", "author": "Author 2" }
        ]')
      end

      it 'loads book data from the file and adds books to the provided array' do
        expect(Book).to receive(:new).with('Book 1', 'Author 1').and_call_original
        expect(Book).to receive(:new).with('Book 2', 'Author 2').and_call_original

        BookLoader.load_books_data(books)

        expect(books.length).to eq(2)
        expect(books[0].title).to eq('Book 1')
        expect(books[0].author).to eq('Author 1')
        expect(books[1].title).to eq('Book 2')
        expect(books[1].author).to eq('Author 2')
      end
    end

    context 'when the books file does not exist or is empty' do
      before do
        allow(File).to receive(:exist?).with('books.json').and_return(false)
        allow(File).to receive(:empty?).with('books.json').and_return(true)
      end

      it 'returns an empty array' do
        expect(Book).not_to receive(:new)

        result = BookLoader.load_books_data(books)

        expect(result).to eq([])
      end
    end
  end

  describe '.load_books_data' do
    context 'when the books file exists and is not empty' do
      before do
        allow(File).to receive(:exist?).with('books.json').and_return(true)
        allow(File).to receive(:empty?).with('books.json').and_return(false)
        allow(File).to receive(:read).with('books.json').and_return('[
          { "title": "Book 1", "author": "Author 1" },
          { "title": "Book 2", "author": "Author 2" }
        ]')
      end

      it 'loads book data from the file and adds books to the provided array' do
        expect(Book).to receive(:new).with('Book 1', 'Author 1').and_call_original
        expect(Book).to receive(:new).with('Book 2', 'Author 2').and_call_original

        BookLoader.load_books_data(books)

        expect(books.length).to eq(2)
        expect(books[0].title).to eq('Book 1')
        expect(books[0].author).to eq('Author 1')
        expect(books[1].title).to eq('Book 2')
        expect(books[1].author).to eq('Author 2')
      end
    end

    context 'when the books file does not exist or is empty' do
      before do
        allow(File).to receive(:exist?).with('books.json').and_return(false)
        allow(File).to receive(:empty?).with('books.json').and_return(true)
      end

      it 'returns an empty array' do
        expect(Book).not_to receive(:new)

        result = BookLoader.load_books_data(books)

        expect(result).to eq([])
      end
    end
  end
end
