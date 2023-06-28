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

  def self.save_persons_to_file(persons)
    existing_data = persons.map do |person|
      person_data = {
        'id' => person.id,
        'name' => person.name,
        'age' => person.age,
        'is_student' => person.is_a?(Student),
        'is_teacher' => person.is_a?(Teacher)
      }

      if person.is_a?(Student)
        person_data['parent_permission'] = person.parent_permission
        person_data['classroom'] = person.classroom
      else
        person_data['specialization'] = person.specialization
      end

      person_data
    end

    File.write('persons.json', JSON.generate(existing_data))
  end
end
