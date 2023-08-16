require_relative 'message_outputs'
require_relative 'class_musicalbum'
require_relative 'class_genre'

# This class represents the main application for the Catalog of my things App.
class App
  include MessageOutputs
  attr_accessor :music_albums, :genre, :authors

  def initialize
    @music_albums = []
    @genre = []
    @authors = []
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
      MusicAlbum.list_all_music_albums(music_albums)
    when 4
      Genre.list_all_genres(genre)
    when 8
      MusicAlbum.add_music_album(music_albums, genre, authors)
    when 10
      goodbye
      exit
    else
      puts 'Invalid number: Please enter a valid number'
    end
  end
end
