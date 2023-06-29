require_relative '../teacher'
require_relative '../person'

describe Teacher do
  describe '#can_use_services?' do
    it 'returns true for teacher' do
      teacher = Teacher.new(35, 'Jane Smith', parent_permission: false, specialization: 'Mathematics')

      expect(teacher.can_use_services?).to eq(true)
    end
  end
end
