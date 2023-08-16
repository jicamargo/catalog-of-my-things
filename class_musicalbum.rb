require './class_item'

# class_musicalbum.rb
class Musicalbum < Item
  attr_accessor :on_spotify

  def initialize(genre, author, label, publish_date, on_spotify)
    super(genre, author, label, publish_date)
    @on_spotify = on_spotify
  end

  def can_be_archived?
    super && !@on_spotify
  end
end
