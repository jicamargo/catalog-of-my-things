# Generic class for all items in the library
class Item
  attr_reader :id, :archived
  attr_accessor :genre, :author, :label, :publish_date

  def initialize(id, genre, author, label, publish_date)
    @id = id
    @genre = genre
    @author = author
    @label = label
    @publish_date = publish_date
    @archived = false
  end

  def can_be_archived?
    !@archived
  end

  def move_to_archive
    @archived = true
  end
end
