# class_musicalbum_handler.rb
require_relative 'class_musicalbum'
require_relative 'class_genre'

class MusicalbumHandler
  attr_reader :musicalbums

  def initialize
    @musicalbums = [] # Initialize the instance variable here
  end

  def add_music_album(genres)
    puts 'Enter album title:'
    title = gets.chomp

    puts 'Select a genre:'
    genre_name = gets.chomp

    select_genre = genres.find { |genre| genre.name.downcase == genre_name.downcase }
    selected_genre = genre_name

    if select_genre.nil?
      puts 'Genre not found.'
      puts 'Do you want to add a new genre? (Y/N):'
      add_genre = gets.chomp.downcase == 'y'

      return unless add_genre

      selected_genre = genre_validator(genres)
    end

    puts 'Is the album on Spotify? (Y/N):'
    on_spotify = gets.chomp.downcase == 'y'

    puts "Musicalbum: '#{selected_genre}' added."
    new_album = Musicalbum.new(selected_genre, nil, title, Time.now, on_spotify)
    @musicalbums << new_album

    puts "Album '#{title}' added."
    puts "Album '#{musicalbums}' added."
  end

  def genre_validator(genres)
    puts 'Input the genre name:'
    name = gets.chomp
    genre = Genre.new(name)
    genres << genre # Add the new genre to the genres array
    genre.name # Update selected_genre with the newly added genre
  end

  def list_musicalbums
    puts 'List of Music Albums:'
    @musicalbums.each do |album|
      puts "Title: #{album.label}, Genre: #{album.genre.nil? ? 'Unknown' : album.genre}"
    end
  end
end
