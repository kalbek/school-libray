require_relative 'app'

def run
  app = App.new
  puts 'Welcome to School Library App!'
  loop do
    display_menu
    choice = gets.chomp.to_i
    puts 'Thank you for using this app!' if choice == 7
    options_choice(app, choice)
  end
end

def display_menu
  puts "\n"
  puts 'Please choose an option by entering a number:'
  puts '1 - List all books'
  puts '2 - List all people'
  puts '3 - Create a person'
  puts '4 - Create a book'
  puts '5 - Create a rental'
  puts '6 - List all rentals for a given person id'
  puts '7 - Exit'
end

def options_choice(app, choice)
  choices = {
    1 => :list_all_books,
    2 => :list_all_people,
    3 => :create_person,
    4 => :create_a_book,
    5 => :create_rental,
    6 => :list_all_rentals,
    7 => :exit
  }
  action = choices[choice]
  if action
    app.send(action)
  else
    puts 'Invalid choice. Please try again.'
  end
end

run
