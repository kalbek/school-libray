require_relative 'book'

def list_all_books
  puts(@books.map { |book| "Title: \"#{book.title}\", Author: #{book.author}" })
end
