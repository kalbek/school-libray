require_relative 'book'
require 'json'

class BookLoader
  def self.load_books_data(books)
    return [] unless File.exist?('books.json') && !File.empty?('books.json')

    book_data = JSON.parse(File.read('books.json'))
    book_data.map do |data|
      book = Book.new(data['title'], data['author'])
      books << book
      puts "booooks: #{books}"
    end
  end
end
