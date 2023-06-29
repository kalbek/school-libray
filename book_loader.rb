require_relative 'book'
require 'json'

class BookLoader
  def self.save_books_to_file(books)
    book_data = books.map do |book|
      {
        'title' => book.title,
        'author' => book.author
      }
    end
    File.write('books.json', JSON.generate(book_data))
  end

  def self.load_books_data(books)
    return [] unless File.exist?('books.json') && !File.empty?('books.json')

    book_data = JSON.parse(File.read('books.json'))
    book_data.map do |data|
      book = Book.new(data['title'], data['author'])
      books << book
    end
  end
end
