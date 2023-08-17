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

      book = Book.new(
        book_data[:genre],
        Label.new(label_title, label_color),
        book_data[:label],
        Date.parse(book_data[:publish_date])
      )
      book.multiplayer = book_data[:multiplayer]
      book.last_played_at = Date.parse(book_data[:last_played_at])
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
        label: book.label,
        publish_date: book.publish_date.to_s,
        multiplayer: book.multiplayer,
        last_played_at: book.last_played_at.to_s,
        archived: book.archived
      }
    end

    File.write(@filename, JSON.pretty_generate(book_data))
  end

  def input_new_book
    puts "### ADDING A NEW GAME ###\n"
    puts "Enter the following information:\n"

    genre = input_genre
    label_title, label_color = input_label
    label = input_label
    publish_date = invalid_date_then_today(input_publish_date)
    multiplayer = input_multiplayer
    last_played_at = invalid_date_then_today(input_last_played_date)

    if valid_input?(genre, label_title, label)
      label = find_or_create_label(label_title, label_color)
      book = create_book(genre, label, label, publish_date)
      book.multiplayer = %w[Y y].include?(multiplayer)
      book.last_played_at = last_played_at

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

  def input_label
    print 'Label (FirstName LastName):'
    label = gets.chomp.split
    [label[0], label[1] || '']
  end

  def input_label
    print 'Label:'
    gets.chomp
  end

  def input_publish_date
    print 'Publish date:'
    gets.chomp
  end

  def input_multiplayer
    print 'Multiplayer (Y/N)?:'
    gets.chomp
  end

  def input_last_played_date
    print 'Last played date:'
    gets.chomp
  end

  def valid_input?(genre, label_title, label)
    !genre.empty? && !label_title.empty? && !label.empty?
  end

  def find_or_create_label(title, color)
    label_handler = LabelHandler.new
    label_handler.find_create_label(title, color)
  end

  def create_book(genre, label, label, publish_date)
    Book.new(genre, label, label, publish_date)
  end

  def save_new_book(book)
    books = load_books
    books << book
    save_books(books)
    puts "\nBook added successfully!"
  end

  def list_books()
    books = load_books
    puts '--------------------- LIST OF GAMES ---------------------'
    books.each do |book|
      puts "ID: #{book.id}"
      puts "Genre: #{book.genre}"
      puts "Label: #{book.label.title} #{book.label.color}"
      puts "Label: #{book.label}"
      puts "Publish Date: #{book.publish_date}"
      puts "Archived: #{book.archived}"
      puts "Multiplayer: #{book.multiplayer}"
      puts "Last Played Date: #{book.last_played_at}"
      puts '---------------------------------------------------------'
    end
  end
end
