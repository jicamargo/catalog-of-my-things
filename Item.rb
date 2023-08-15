# Generic class for all items in the library
class Item
  attr_reader :id, :archived
  attr_accessor :genre, :author, :label, :publish_date

  @@id_counter = 0  # Class-level counter for generating unique IDs

  def initialize(genre, author, label, publish_date)
    @id = generate_id
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

  private

  def generate_id
    @@id_counter += 1
  end
end
