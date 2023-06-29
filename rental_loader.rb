require_relative 'book'
require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'classroom'
require_relative 'rental'
require 'json'

class RentalLoader
  def self.load_rentals_data
    rentals = []
    if File.exist?('rentals.json') && !File.empty?('rentals.json')
      rental_data = JSON.parse(File.read('rentals.json'))
      rental_data.each do |data|
        book = Book.new(data['book']['title'], data['book']['author'])
        selected_person = if data['person']['is_student']
                            RentalLoader.select_student(data)
                          else
                            RentalLoader.select_teacher(data)
                          end

        rental = Rental.new(data['date'], book, selected_person)
        rentals << rental
      end
    end
    rentals
  end

  def self.select_student(data)
    age = data['person']['age']
    name = data['person']['name']
    parent_permission = data['person']['parent_permission']
    id = data['person']['id']
    Student.new(age, 'Programming', name,
                parent_permission: parent_permission, id: id)
  end

  def self.select_teacher(data)
    Teacher.new(data['person']['age'], data['person']['name'],
                specialization: data['person']['specialization'], id: data['person']['id'])
  end

  def self.save_rentals_to_file(rentals)
    existing_rental_data = []
    rentals.each do |rental|
      rental_data = {
        'date' => rental.date,
        'book' => {
          'title' => rental.book.title,
          'author' => rental.book.author
        },
        'person' => {
          'id' => rental.person.id,
          'name' => rental.person.name,
          'age' => rental.person.age,
          'is_teacher' => rental.person.is_a?(Teacher),
          'is_student' => rental.person.is_a?(Student)
        }
      }
      existing_rental_data << rental_data
    end
    File.write('rentals.json', JSON.generate(existing_rental_data))
  end
end
