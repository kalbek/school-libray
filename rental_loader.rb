require_relative 'book'
require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'classroom'
require_relative 'rental'
require 'json'

class RentalLoader
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
      File.write('rentals.json', JSON.generate(existing_rental_data))
    end
  end
end
