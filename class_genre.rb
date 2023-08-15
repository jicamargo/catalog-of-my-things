# class_genre.rb
class Genre < Item
  attr_reader :name, :items

  def initialize(name)
    super(nil, nil, nil, nil) # Call superclass constructor with nil values
    @name = name
    @items = []
  end

  # take an instance of the Item class and add it to the items array
  def add_item(item)
    @items << item
    item.genre = self # associate the item with the genre
  end
end
