require_relative 'app'
class Main
  def initialize
    @books = []
    @book_title = ''
    @book_author = ''
    @persons = []
    @name = ''
    @age = ''
    @parent_permission = false
    @specialization = ''
    @rentals = []
  end

  def main
    puts 'Welcome to School Library App!'
    loop do
      display_menu
      choice = gets.chomp.to_i
      puts 'Thank you for using this app!' if choice == 7
      process_choice(choice) == :exit
    end
  end

  def process_choice(choice)
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
      send(action)
    else
      puts 'Invalid choice. Please try again.'
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

  if __FILE__ == $PROGRAM_NAME
    entry = Main.new
    entry.main
  end
end
