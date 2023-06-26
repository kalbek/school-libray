require_relative 'book'
require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'classroom'
require_relative 'rental'

class App
  def initialize
    @books = []
    @book_title = ''
    @book_author = ''
    @persons = []
    @name = ''
    @age = ''
    @parent_permission = false
    @specialization = ''
    @rentals = []
  end

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

  def create_rental
    display_available_books
    book = selected_book
    return unless book

    display_persons
    selected_person = select_person
    return unless selected_person

    rental_date = rent_date

    rental = Rental.new(rental_date, book, selected_person)
    @rentals << rental

    puts 'Rental created successfully.'
  end

  def display_available_books
    puts 'Select a book from the following list by number:'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: #{book.title}, Author: #{book.author}"
    end
  end

  def selected_book
    print 'Book index: '
    book_index = gets.chomp.to_i
    return unless (0...@books.length).cover?(book_index)

    @books[book_index]
  end

  def display_persons
    puts 'Select a person from the following list by number (not id):'
    @persons.each_with_index do |person, index|
      role = person.is_a?(Student) ? 'Student' : 'Teacher'
      puts "#{index}) [#{role}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def select_person
    print 'Person index: '
    person_index = gets.chomp.to_i
    return unless (0...@persons.length).cover?(person_index)

    @persons[person_index]
  end

  def rent_date
    print 'Date: '
    gets.chomp
  end

  def list_all_rentals
    print 'ID of person: '
    person_id = gets.chomp.to_i
    puts 'Rentals:'
    puts(@rentals.map do |rental|
      "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.book.author}" if rental.person.id == person_id
    end.compact)
  end
end
