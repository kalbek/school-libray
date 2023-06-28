require_relative 'book'
require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'classroom'
require_relative 'rental'
require 'json'

class PersonLoader
  def self.load_persons_data(persons)
    return [] unless File.exist?('persons.json') && !File.empty?('persons.json')

    persons_data = JSON.parse(File.read('persons.json'))
    persons_data.each do |data|
      if data['is_student']
        student = Student.new(data['age'], 'Programming', data['name'], parent_permission: data['parent_permission'],
                                                                        id: data['id'])
        puts 'inserting student'
        persons << student
      else
        teacher = Teacher.new(data['age'], data['name'], specialization: data['specialization'], id: data['id'])
        puts 'inserting teacher'
        persons << teacher
      end
    end
    persons
  end
end
