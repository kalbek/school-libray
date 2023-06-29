require_relative 'spec_helper'
require_relative '../app'

RSpec.describe App do
  let(:app) { App.new }

  describe '#create_person' do
    before do
      allow(app).to receive(:gets).and_return("1\n", "20\n", "John\n", "y\n", '')
    end

    it 'creates a student' do
      expect { app.create_person }.to change { app.instance_variable_get(:@persons).length }.by(1)

      student = app.instance_variable_get(:@persons).last
      expect(student).to be_a(Student)
      expect(student.name).to eq('John')
      expect(student.age).to eq('20')
      expect(student.parent_permission).to be(true)
    end
  end

  describe '#create_a_book' do
    before do
      allow(app).to receive(:gets).and_return("Book 1\n", "Author 1\n")
    end

    it 'creates a book' do
      expect { app.create_a_book }.to change { app.instance_variable_get(:@books).length }.by(1)

      book = app.instance_variable_get(:@books).last
      expect(book).to be_a(Book)
      expect(book.title).to eq('Book 1')
      expect(book.author).to eq('Author 1')
    end
  end

  describe '#create_rental' do
    before do
      app.instance_variable_set(:@books, [Book.new('Book 1', 'Author 1')])
      app.instance_variable_set(:@persons, [Student.new('20', 'Programming', 'John', parent_permission: true)])
      allow(app).to receive(:gets).and_return("0\n", "0\n", "2023-06-01\n")
    end

    it 'creates a rental' do
      expect { app.create_rental }.to change { app.instance_variable_get(:@rentals).length }.by(1)

      rental = app.instance_variable_get(:@rentals).last
      expect(rental).to be_a(Rental)
      expect(rental.date).to eq('2023-06-01')
      expect(rental.book.title).to eq('Book 1')
      expect(rental.book.author).to eq('Author 1')
      expect(rental.person.name).to eq('John')
    end
  end
end
