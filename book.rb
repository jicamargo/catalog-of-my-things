require_relative 'add_items'
require_relative 'label'

class Book < Item
  attr_accessor :publisher, :cover_state, :id

  def initialize(publisher, cover_state, *args)
    super(*args)
    @publisher = publisher
    @cover_state = cover_state
  end

  def self.list_all_books(books)
    index = 1
    if books.empty?
      puts 'No Books found'
    else
      puts 'List of all books: '
      books.each do |book|
        if book.instance_of? Book
          puts "#{index}) (ID:#{book.id}) The book: #{book.label.title} , Author: #{book.author.first_name} #{book.author.last_name}, Genre: #{book.genre.name}, Publish Date: #{book.publish_date}"
          index += 1
        end
      end
    end
  end

  # rtfuihk
  def self.add_books(books, genre, authors, labels)
    print 'Enter name of the book: '
    label_title = gets.chomp.capitalize
    print 'Book\'s creator first name: '
    author_first_name = gets.chomp.capitalize
    print 'Book\'s creator last name: '
    author_last_name = gets.chomp.capitalize
    print 'Enter the book\'s genre: '
    genre_name = gets.chomp.capitalize
    print 'Enter the book\'s publisher: '
    publisher_name = gets.chomp.capitalize
    print 'Enter the book\'s cover state: '
    cover_state = gets.chomp.capitalize
    print 'Enter the book\'s color: '
    label_color = gets.chomp.capitalize

    # item inputs
    print "\nWhat's the publish date? [year] "
    print "\nAnswer: "
    book_date = gets.chomp.to_i

    new_book = Book.new(publisher_name, cover_state, book_date)

    new_author = authors.find do |find_author|
      find_author.first_name == author_first_name && find_author.last_name == author_last_name
    end
    new_genre = genre.find { |find_genre| find_genre.name == genre_name }
    new_label = labels.find { |find_label| find_label.title == label_title && find_label.color == label_color }

    if new_author.nil?
      new_author = Author.new(author_first_name, author_last_name)
      authors << new_author
    end

    if new_genre.nil?
      new_genre = Genre.new(genre_name)
      genre << new_genre
    end

    if new_label.nil?
      new_label = Label.new(label_title, label_color)
      labels << new_label
    end

    new_genre.add_item(new_book)
    new_author.add_item(new_book)
    new_label.add_item(new_book)

    books << new_book

    puts 'Book added successfully'
  end

  private

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end
