require_relative '../person_loader'
require_relative '../book'
require_relative '../person'
require_relative '../student'
require_relative '../teacher'
require_relative '../classroom'
require_relative '../rental'
require 'json'

RSpec.describe PersonLoader do
  describe '.load_persons_data' do
    context 'when the persons data file exists and is not empty' do
      let(:persons_data) do
        [
          { 'id' => 1, 'name' => 'John Doe', 'age' => 20, 'is_student' => true, 'parent_permission' => true },
          { 'id' => 2, 'name' => 'Jane Smith', 'age' => 25, 'is_student' => false, 'specialization' => 'Math' }
        ]
      end

      before do
        allow(File).to receive(:exist?).with('persons.json').and_return(true)
        allow(File).to receive(:empty?).with('persons.json').and_return(false)
        allow(File).to receive(:read).with('persons.json').and_return(persons_data.to_json)
      end

      it 'loads and returns the persons' do
        persons = []
        expect(Student).to receive(:new).with(20, 'Programming', 'John Doe', parent_permission: true,
                                                                             id: 1).and_return(instance_double(Student))
        expect(Teacher).to receive(:new).with(25, 'Jane Smith', specialization: 'Math',
                                                                id: 2).and_return(instance_double(Teacher))
        expect(persons).to receive(:<<).twice

        loaded_persons = PersonLoader.load_persons_data(persons)

        expect(loaded_persons).to eq(persons)
      end
    end

    context 'when the persons data file does not exist or is empty' do
      before do
        allow(File).to receive(:exist?).with('persons.json').and_return(false)
        allow(File).to receive(:empty?).with('persons.json').and_return(true)
      end

      it 'returns an empty array' do
        persons = []

        loaded_persons = PersonLoader.load_persons_data(persons)

        expect(loaded_persons).to eq([])
      end
    end
  end

  describe '.save_persons_to_file' do
    let(:persons) do
      [
        Student.new(20, 'John Doe', parent_permission: true),
        Teacher.new(25, 'Jane Smith', specialization: 'Math')
      ]
    end

    it 'saves the persons data to a file' do
      expect(File).to receive(:write).with('persons.json', anything)
      PersonLoader.save_persons_to_file(persons)
    end
  end
end
