class Rental
  attr_accessor :date, :book

  def initialize(date)
    @date = date
    @book = book
    book.add_rental(self)
  end
end
