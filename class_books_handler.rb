# class_books_handler.rb

require 'json'
require_relative 'class_book'
require_relative 'class_labels_handler'
require_relative 'date_validator'
require_relative 'file_validator'

class BookHandler
  include DateValidator
  include FileValidator

  def initialize
    @books = []
    @filename = 'json_data/books.json'
  end

  def load_books()
    data = read_json_file(@filename)

    data.map do |book_data|
      label_data = book_data[:label]
      label_title = label_data[:title]
      label_color = label_data[:color]

      book_data[:label]

      book = Book.new(
        book_data[:genre],
        Label.new(label_title, label_color),
        book_data[:label],
        Date.parse(book_data[:publish_date])
      )
      book.label = label_data
      book.author = book_data[:author]
      book.cover_state = book_data[:cover_state]
      book.publisher = book_data[:publisher]
      book.archived = book_data[:archived]
      book
    end
  end

  def save_books(books)
    return if books.nil? || books.empty?

    book_data = books.map do |book|
      {
        id: book.id,
        genre: book.genre,
        label: { title: book.label.title, color: book.label.color },
        author: book.author,
        publish_date: book.publish_date.to_s,
        cover_state: book.cover_state,
        publisher: book.publisher,
        archived: book.archived
      }
    end

    File.write(@filename, JSON.pretty_generate(book_data))
  end

  def input_new_book
    puts "### ADDING A NEW BOOK ###\n"
    puts "Enter the following information:\n"

    genre = input_genre
    author = input_author
    title = input_title
    color = input_color
    publish_date = invalid_date_then_today(input_publish_date)
    cover_state = input_cover_state
    publisher = input_publisher

    if valid_input?(author, title, color)
      label = find_or_create_label(title, color)
      book = create_book(genre, author, label, publish_date)
      book.cover_state = cover_state
      book.publisher = publisher

      save_new_book(book)
    else
      puts 'Genre, label, and label are mandatory fields!'
      puts 'Book not added!'
    end
  end

  def input_genre
    print 'Genre:'
    gets.chomp
  end

  def input_author
    print 'Author:'
    gets.chomp
  end

  def input_title
    print 'Title:'
    gets.chomp
  end

  def input_color
    print 'Color:'
    gets.chomp
  end

  def input_publish_date
    print 'Publish date:'
    gets.chomp
  end

  def input_cover_state
    print 'Cover state:'
    gets.chomp
  end

  def input_publisher
    print 'Publisher:'
    gets.chomp
  end

  def valid_input?(author, title, color)
    !author.empty? && !title.empty? && !color.empty?
  end

  def find_or_create_label(title, color)
    label_handler = LabelHandler.new
    label_handler.find_create_label(title, color)
  end

  def create_book(genre, author, label, publish_date)
    Book.new(genre, author, label, publish_date)
  end

  def save_new_book(book)
    books = load_books
    books << book
    save_books(books)
    puts "\nBook added successfully!"
  end

  def list_books()
    books = load_books
    puts '--------------------- LIST OF BOOKS ---------------------'
    books.each do |book|
      puts "ID: #{book.id}"
      puts "Author: #{book.author}"
      # puts "Label: #{book.label.title} #{book.label.color}"
      puts "Publish Date: #{book.publish_date}"
      puts "Cover state: #{book.cover_state}"
      puts "Publisher: #{book.publisher}"
      puts "Archived: #{book.archived}"
      puts '---------------------------------------------------------'
    end
  end
end
