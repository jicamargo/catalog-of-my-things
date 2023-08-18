require 'securerandom'

# class_item.rb
class Item
  attr_reader :id, :archived, :genre, :author, :label
  attr_accessor :publish_date

  def initialize(genre, author, label, publish_date)
    @id = generate_id
    @publish_date = publish_date
    @archived = false
    @genre = genre
    @author = author
    @label = label
  end

  # "belongs-to" relationship
  def genre=(genre)
    @genre = genre
    genre.items << self unless genre.items.include?(self)
  end

  def author=(author)
    @author = author
    author.items << self unless author.items.include?(self)
  end

  def label=(label)
    @label = label
    label.items << self unless label.items.include?(self)
  end

  # return true if published_date is older than 10 years.
  def can_be_archived?
    Time.now.year - @publish_date.year > 10
  end

  # reuse can_be_archived?() method.
  def move_to_archive
    @archived = true if can_be_archived?
  end

  private

  def generate_id
    SecureRandom.random_number(1000)
  end
end
