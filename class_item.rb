require 'securerandom'

# class_item.rb
class Item
  attr_reader :id, :archived
  attr_accessor :genre, :author, :label, :publish_date

  def initialize(genre, author, label, publish_date)
    @id = generate_id
    @genre = genre
    @author = author
    @label = label
    @publish_date = publish_date
    @archived = false
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
