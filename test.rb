require_relative 'classroom'
require_relative 'student'
require_relative 'book'
require_relative 'person'
require_relative 'rental'
require 'date'

# Create a classroom and some students.
math_classroom = Classroom.new('Math')
Person.new(18, 'John Doe')
john_doe = Student.new(18, 'Math Classroom', 'John Doe')
jane_doe = Student.new(18, 'A', 'Jane Doe')

# Add the students to the classroom.
math_classroom.add_student(john_doe)
math_classroom.add_student(jane_doe)

# Create some books and a person.
book1 = Book.new('The Great Gatsby', 'F. Scott Fitzgerald')
book2 = Book.new('To Kill a Mockingbird', 'Harper Lee')
person1 = Person.new('Alice', 25)

# Rent some books.
Rental.new(Date.today - 7, book1, person1)
Rental.new(Date.today - 14, book2, person1)

puts "Classroom: #{math_classroom.label}"
puts "Students: #{math_classroom.students.map(&:name).join(', ')}"
puts "Book rentals for #{person1.name}:"
puts person1.rentals.map { |r| "#{r.book.title} (#{r.date})" }.join("\n")
