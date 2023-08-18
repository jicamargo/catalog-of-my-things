# class_musicalbum_handler.rb
require_relative 'class_musicalbum'
require_relative 'class_genres_handler'
require_relative 'class_labels_handler'
require_relative 'class_authors_handler'
require_relative 'class_genre'

class MusicalbumHandler
  attr_reader :musicalbums, :genres_handler, :labels_handler, :authors_handler

  def initialize
    @musicalbums = [] # Initialize the instance variable here
    @genre_handler = GenreHandler.new
    @label_handler = LabelHandler.new
    @author_handler = AuthorHandler.new
  end

  def add_music_album
    puts "### ADDING A NEW ALBUM ###\n"
    puts "Enter the following information:\n"

    genres = @genre_handler.load_genres

    puts 'Select a genre:'
<<<<<<< HEAD
    genre_name = gets.chomp.capitalize
    select_genre = genres.find { |genre| genre.name.downcase == genre_name.downcase }
    if select_genre.nil?
      puts "Genre '#{genre_name}' not found."
      print 'Do you want to add it? (Y/N):'
=======
    genre_name = gets.chomp.downcase

    selected_genre = genres.find { |genre| genre.name.downcase == genre_name }

    if selected_genre.nil?
      puts 'Genre not found.'
      puts 'Do you want to add a new genre? (Y/N):'
>>>>>>> 687654a5e18f8fb1e417dbf29fcda55aadea9bee
      add_genre = gets.chomp.downcase == 'y'

      return unless add_genre
      # selected_genre = genre_validator(genres)
    end
    print 'Enter album title:'
    title = gets.chomp
    author_first_name, author_last_name = input_author

    print 'Is the album on Spotify? (Y/N):'
    on_spotify = gets.chomp.downcase == 'y'

<<<<<<< HEAD
    if valid_input?(genre_name, author_first_name, title)
      genre = @genre_handler.find_create_genre(genre_name)
      label = @label_handler.find_create_label(title, 'Album')
      author = @author_handler.find_create_author(author_first_name, author_last_name)

      new_album = Musicalbum.new(genre, author, label, Time.now, on_spotify)
      @musicalbums << new_album
      # save_new_album(new_album)
      puts "Genre: '#{genre_name}' selected."
      puts "Album '#{title}' added."
    else
      puts 'Genre, author, and title are mandatory fields!'
      puts 'Album not added!'
    end
  end

  def input_author
    print 'Author (FirstName LastName):'
    author = gets.chomp.split
    [author[0], author[1] || '']
=======
    puts "Musicalbum: '#{selected_genre}' added."
    new_album = Musicalbum.new(selected_genre, nil, title, Time.now, on_spotify)
    @musicalbums << new_album

    puts "Album '#{title}' added."
    puts "Album '#{musicalbums}' added."
>>>>>>> 687654a5e18f8fb1e417dbf29fcda55aadea9bee
  end

  def genre_validator(genres)
    puts 'Input the genre name:'
    name = gets.chomp
    genre = Genre.new(name)
    genres << genre # Add the new genre to the genres array
    genre.name # Update selected_genre with the newly added genre
  end

  def valid_input?(genre, author_first_name, label)
    !genre.empty? && !author_first_name.empty? && !label.empty?
  end

  def list_musicalbums
    puts '------------------------  LIST OF MUSIC ALBUMS ------------------------'
    puts 'ID  |        TITLE        |      GENRE      |  ON SPOTIFY  '
    @musicalbums.each do |album|
      label_title = album.label.title.to_s
      genre = album.genre.name.to_s
      on_spotify = album.on_spotify.to_s

      puts "#{album.id.to_s.ljust(4)}|#{label_title.ljust(20)} | #{genre.ljust(15)} |     #{on_spotify.ljust(5)}     "
    end
    puts '-----------------------------------------------------------------------'
  end
end
