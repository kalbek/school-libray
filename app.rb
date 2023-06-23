require_relative 'book'
require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'classroom'

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

def create_person
  print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
  person_choice = gets.chomp.to_i

  case person_choice
  when 1
    create_student
  when 2
    create_teacher
  else
    puts 'Invalid choice.'
  end

  puts 'Person created successfully.'
end

def create_student
  print 'Age: '
  age = gets.chomp
  print 'Name: '
  name = gets.chomp
  parent_permission = select_parent_permission

  student = Student.new(age, 'Default Classroom', name, parent_permission: parent_permission)
  @persons << student
end

def select_parent_permission
  print 'Has parent permission? [Y/N]: '
  permission = gets.chomp.downcase

  case permission
  when 'y'
    true
  when 'n'
    false
  else
    puts 'Invalid input!'
    select_parent_permission
  end
end

def create_teacher
  print 'Age: '
  age = gets.chomp.to_i
  print 'Name: '
  name = gets.chomp.to_s
  print 'Specialization: '
  specialization = gets.chomp.to_s

  teacher = Teacher.new(age, name, specialization: specialization)
  @persons << teacher
end

def create_a_book
  print 'Title: '
  @book_title = gets.chomp
  print 'Author: '
  @book_author = gets.chomp
  book = Book.new(@book_title, @book_author)
  print 'Book created successfully'
  @books << book
  print "\n"
end
