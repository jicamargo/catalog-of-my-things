class App
  include MessageOutputs
  attr_accessor :music_albums, :genre, :author
  
    def initialize
      @music_albums = []
      @genre = []
      @author = []
    end
  
    def run 
      greetings
      loop do 
        num_choice = otpions
        otpion_selected(num_choice)
      end
    end
  
    def otpion_selected(number)
      case number
      when 2
        MusicAlbum.list_all_music_album(music_albums)
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