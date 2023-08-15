# class_genre.rb
# The Genre class inherits from the Item class using the super keyword
# in the constructor to initialize the properties defined in the Item class.
# Genre Class has additional properties: id:int, name:string, items:array, which are specific to genres.
class Genre < Item
  attr_reader :id, :name, :items

  @@id_counter = 0 # Class-level counter for generating unique IDs

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

  private

  def generate_id
    @@id_counter += 1
  end
end
