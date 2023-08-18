# class_genre.rb
require_relative 'class_item'
class Genre < Item
  attr_reader :name, :items
  attr_accessor :id

  def initialize(name)
    @id = generate_id
    @name = name
    @items = []
  end

  # take an instance of the Item class and add it to the items array
  def add_item(item)
    @items << item
    item.genre = self # associate the item with the genre
  end

  def generate_id
    SecureRandom.random_number(1000)
  end
end
