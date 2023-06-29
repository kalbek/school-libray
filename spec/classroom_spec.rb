require_relative '../classroom'

describe Classroom do
  describe '#add_student' do
    it 'adds a student to the classroom' do
      classroom = Classroom.new('A101')
      student = double('student')

      expect(student).to receive(:classroom=).with(classroom)
      classroom.add_student(student)

      expect(classroom.students).to include(student)
    end
  end
end
