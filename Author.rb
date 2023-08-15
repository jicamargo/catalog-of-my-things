require_relative 'Item'

# Author class 
# The initialize method takes parameters for the first_name and last_name
# and set them during object creation. The id property is generated automatically.
# The add_item method allows you to associate an item with the author 
# by adding it to the items array.
class Author
  attr_reader :id, :first_name, :last_name, :items

  @@id_counter = 0  # Class-level counter for generating unique IDs

  def initialize(first_name, last_name)
    @id = generate_id
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def add_item(item)
    @items << item
  end

  private

  def generate_id
    @@id_counter += 1
  end
end
