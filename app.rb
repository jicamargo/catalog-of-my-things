require_relative 'message_outputs'
require_relative 'message_outputs'
require_relative 'class_genre_handler'
require_relative 'class_musicalbum_handler'

class App
  include MessageOutputs
  attr_accessor :musicalbum_handler, :genre_handler, :music_albums

  def initialize
    @musicalbum_handler = MusicalbumHandler.new
    @genre_handler = GenreHandler.new
    @music_albums = [] # Initialize the instance variable here
  end

  def run
    greetings
    loop do
      number_choice = options
      option_selected(number_choice)
    end
  end

  def option_selected(number)
    case number
    when 2
      musicalbum_handler.list_musicalbums
    when 4
      genre_handler.list_genres
    when 8
      musicalbum_handler.add_music_album(genre_handler.genres)
    when 10
      goodbye
      exit
    else
      puts 'Invalid number: Please enter a valid number'
    end
  end
end
