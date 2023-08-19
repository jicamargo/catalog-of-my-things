require_relative 'class_item'

# The Game class inherits from the Item class using the super keyword
# in the constructor to initialize the properties defined in the Item class.
# Game Class has additional properties: multiplayer and last_played_at,
# which are specific to games.
class Game < Item
  attr_accessor :multiplayer, :last_played_at, :archived, :id

  def initialize(genre, author, label, publish_date)
    super(genre, author, label, publish_date) # Call superclass constructor
    @multiplayer = false
    @last_played_at = Date.today
  end

  # override can_be_archived? method from Item return true if parent's method
  # returns true AND if last_played_at is older than 2 years otherwise, it should return false
  def can_be_archived?
    super && @last_played_at < 2.years.ago
  end
end
