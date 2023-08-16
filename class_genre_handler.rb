# class_genre_handler.rb

require_relative 'class_genre'

class GenreHandler
  attr_reader :genres

  def initialize
    @genres = [] # Initialize the instance variable here
  end

  def input_new_genre
    puts 'Input the genre name:'
    name = gets.chomp
    genre = Genre.new(name)
    @genres << genre
  end

  def list_genres
    puts 'Genres list:'
    @genres.each do |genre|
      puts genre.name
    end
  end
end
