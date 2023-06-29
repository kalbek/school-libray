require_relative '../student'
require_relative '../person'
require_relative '../classroom'

describe Student do
  describe '#play_hooky' do
    it 'returns a string representing playing hooky' do
      student = Student.new(18, 'Classroom 1', 'John Doe')

      expect(student.play_hooky).to eq('¯(ツ)/¯')
    end
  end
end
