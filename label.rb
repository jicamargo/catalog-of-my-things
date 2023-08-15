require 'securerandom'

class Label
  attr_accessor :id, :title, :color, :items

  def initialize(title, color, _id = SecureRandom.random_number(1000))
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    @items << item
    item.add_label(self)
  end
end
