require 'json'
require_relative 'class_book'
require_relative 'class_genre'
require_relative 'class_labels_handler'
require_relative 'class_authors_handler'
require_relative 'class_genres_handler'
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
      genre = Genre.new(book_data[:genre][:name])
      genre.id = book_data[:genre][:id]
      label = Label.new(book_data[:label][:title], book_data[:label][:color])
      label.id = book_data[:label][:id]
      author = Author.new(book_data[:author][:first_name], book_data[:author][:last_name])
      author.id = book_data[:author][:id]

      book = Book.new(
        book_data[:genre],
        book_data[:author],
        book_data[:label],
        Date.parse(book_data[:publish_date])
      )

      book.id = book_data[:id]
      book.genre = genre
      book.label = label
      book.author = author
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
        genre: { id: book.genre.id, name: book.genre.name },
        label: { id: book.label.id, title: book.label.title, color: book.label.color },
        author: { id: book.author.id, first_name: book.author.first_name, last_name: book.author.last_name },
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

    genre_name = input_genre
    author_first_name, author_last_name = input_author
    title = input_title
    color = input_color
    publish_date = invalid_date_then_today(input_publish_date)
    cover_state = input_cover_state
    publisher = input_publisher

    if valid_input?(genre_name, author_first_name, title)
      genre = find_create_genre(genre_name)
      author = find_create_author(author_first_name, author_last_name)
      label = find_create_label(title, color)
      book = create_book(genre, author, label, publish_date)
      book.cover_state = cover_state
      book.publisher = publisher

      save_new_book(book)
    else
      puts 'Genre, Author, and Title are mandatory fields!'
      puts 'Book not added!'
    end
  end

  def input_genre
    print 'Genre:'
    gets.chomp.capitalize
  end

  def input_author
    print 'Author (FirstName LastName):'
    author = gets.chomp.split
    [author[0], author[1] || '']
  end

  def input_title
    print 'Title:'
    gets.chomp.capitalize
  end

  def input_color
    print 'Color:'
    gets.chomp.capitalize
  end

  def input_publish_date
    print 'Publish date:'
    gets.chomp
  end

  def input_cover_state
    print 'Cover state:'
    gets.chomp.capitalize
  end

  def input_publisher
    print 'Publisher:'
    gets.chomp.capitalize
  end

  def valid_input?(genre, author, title)
    !genre.empty? && !author.empty? && !title.empty?
  end

  def find_create_genre(name)
    genre_handler = GenreHandler.new
    genre_handler.find_create_genre(name)
  end

  def find_create_label(title, color)
    label_handler = LabelHandler.new
    label_handler.find_create_label(title, color)
  end

  def find_create_author(first_name, last_name)
    author_handler = AuthorHandler.new
    author_handler.find_create_author(first_name, last_name)
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
    puts '------------------------------- LIST OF BOOKS -------------------------------'
    puts 'ID  |        TITLE        |      AUTHOR     |    PUBLISHER    | PUBLISH DATE '
    books.each do |book|
      label_title = "#{book.label.title} - #{book.label.color}"
      author_name = "#{book.author.first_name} #{book.author.last_name}"
      publish_date = book.publish_date.to_s
      publisher = book.publisher.to_s
      puts "#{book.id.to_s.ljust(4)}|#{label_title.ljust(20)} | #{author_name.ljust(15)} | #{publisher.ljust(15)} | #{publish_date} "
    end
    puts '-----------------------------------------------------------------------------'
  end
end
