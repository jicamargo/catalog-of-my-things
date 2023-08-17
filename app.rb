require_relative 'message_outputs'
require_relative 'class_genre_handler'
require_relative 'class_musicalbum_handler'

require_relative 'class_games_handler'
require_relative 'class_author'

class App
  include MessageOutputs
  attr_accessor :musicalbum_handler, :genre_handler, :music_albums, :author_handler, :game_handler

  def initialize
    @musicalbum_handler = MusicalbumHandler.new
    @genre_handler = GenreHandler.new
    @music_storage = Storage.new
    @music_albums = [] # Initialize the instance variable here
    @author_handler = AuthorHandler.new
    @game_handler = GameHandler.new
  end

  def run
    greetings
    loop do
      number_choice = options
      option_selected(number_choice)
    end
  ensure
    save_genres_json
    save_albums_json
  end

  def option_selected(number)
    case number
    when 2
      musicalbum_handler.list_musicalbums
    when 3
      game_handler.list_games
    when 4
      genre_handler.list_genres
    when 6
      author_handler.list_authors
    when 8
      musicalbum_handler.add_music_album(genre_handler.genres)
    when 9
      game_handler.input_new_game
    when 10
      goodbye
      exit
    else
      puts 'Invalid number: Please enter a valid number'
    end
  end

  def save_genres_json
    @music_storage.save_genres_json(@genre_handler.genres) # Call correct method
  end

  def load_genres_json
    @music_storage.load_genres_json(@genre_handler.genres) # Call correct method
  end

  def load_albums_json
    @music_storage.load_musicalbum_json(musicalbum_handler.musicalbums)
  end

  def save_albums_json
    @music_storage.save_musicalbum_json(musicalbum_handler.musicalbums)
  end
end
