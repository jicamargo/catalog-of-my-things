# class_genre_handler.rb

require_relative 'class_genre'
require_relative 'file_validator'

class GenreHandler
  attr_reader :genres

  include FileValidator

  def initialize
    @genres = [] # Initialize the instance variable here
    @filename = 'json_data/genres.json'
  end

  def input_new_genre
    puts 'Input the genre name:'
    name = gets.chomp
    genre = Genre.new(name)
    @genres << genre
  end

  # def list_genres
  #   puts 'Genres list:'
  #   @genres.each do |genre|
  #     puts genre.name
  #   end
  # end

  def load_genres()
    data = read_json_file(@filename)
    data.map do |genre_data|
      genre = Genre.new(genre_data[:name])
      genre.id = genre_data[:id]
      genre
    end
  end

  def save_genres(genres)
    return if genres.nil? || genres.empty?

    genre_data = genres.map do |genre|
      {
        id: genre.id,
        name: genre.name.strip.capitalize
      }
    end

    File.write(@filename, JSON.pretty_generate(genre_data))
  end

  def list_genres()
    genres = load_genres
    puts '------------------ LIST OF GENRES ------------------'
    genres.each do |genre|
      id = genre.id.to_s.ljust(4)
      name = genre.name.strip.capitalize
      puts "#{id}  #{name}"
    end
    puts '----------------------------------------------------'
  end

  # find if the genre exits, otherwise create a new one
  def find_create_genre(genre_name)
    trimmed_genre_name = genre_name.strip.capitalize

    genres = load_genres # load genres from json file

    existing_genre = genres.find do |genre|
      existing_genre_name = genre.name.strip.capitalize
      existing_genre_name == trimmed_genre_name
    end

    if existing_genre.nil?
      genre = Genre.new(trimmed_genre_name)
      genres << genre
      save_genres(genres)
      genre
    else
      existing_genre
    end
  end
end
