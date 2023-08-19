require_relative 'class_item'
require 'securerandom'

class Label
  attr_accessor :id, :title, :color, :items

  def initialize(title, color)
    @id = generate_id
    @title = title
    @color = color
    @items = []
  end

  # take an instance of the Item class and add it to the items array
  def add_item(item)
    @items << item
    item.label = self # associate the item with the label
  end

  def generate_id
    SecureRandom.random_number(1000)
  end
end
