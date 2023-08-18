require_relative 'class_item'
require 'securerandom'

# Author class
# The initialize method takes parameters for the first_name and last_name
# and set them during object creation. The id property is generated automatically.
# The add_item method allows you to associate an item with the author
# by adding it to the items array.
class Author
  attr_reader :first_name, :last_name, :items
  attr_accessor :id

  def initialize(first_name, last_name)
    @id = generate_id
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  # take an instance of the Item class and add it to the items array
  def add_item(item)
    @items << item
    item.author = self # associate the item with the author
  end

  private

  def generate_id
    SecureRandom.random_number(1000)
  end
end
