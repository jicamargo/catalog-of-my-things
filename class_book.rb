require_relative 'class_item'

class Book < Item
  attr_accessor :publisher, :cover_state, :archived

  def initialize(genre, author, label, publish_date)
    super(genre, author, label, publish_date) # Call superclass constructor
    @publisher = ''
    @cover_state = 'good'
  end

  # override can_be_archived? method from Item return true if parent's method
  # returns true OR if cover_state is bad otherwise, it should return false

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end
