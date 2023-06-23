require_relative 'book'
require_relative 'person'

def list_all_books
  puts(@books.map { |book| "Title: \"#{book.title}\", Author: #{book.author}" })
end

def list_all_people
  if @persons.empty?
    puts 'No persons found! Create some persons.'
  else
    @persons.each do |person|
      role = person.is_a?(Student) ? 'Student' : 'Teacher'
      output = "[#{role}] Name: #{person.name}, Id: #{person.id}, Age: #{person.age}"
      puts output
    end
  end
end
