require_relative 'app'
require_relative 'class_genre'
require_relative 'class_musicalbum'
require 'json'

class Storage
  def save_genres_json(genres)
    genres_data = genres.map do |gen|
      {
        'genre' => gen.name
      }
    end
    File.write('json_data/genres.json', JSON.generate(genres_data))
  end

  def load_genres_json(genres)
    unless File.exist?('json_data/genres.json')
      puts 'No genres found.'
      return
    end
    genres_data = JSON.parse(File.read('json_data/genres.json'))

    genres_data.each do |genre_data|
      genre = Genre.new(genre_data['genre'])
      genres << genre
    end

    puts 'Genres loaded successfully!'
  end

  def save_musicalbum_json(musicalbums)
    musicalbum_data = musicalbums.map do |music_album|
      {
        'genre' => music_album.genre.nil? ? nil : music_album.genre,
        'author' => music_album.author, # Assuming you have an author attribute
        'label' => music_album.label,
        'publish_date' => music_album.publish_date.to_s, # Convert to string if DateTime
        'on_spotify' => music_album.on_spotify
      }
    end

    puts 'Saving album data:'
    puts musicalbum_data.inspect

    File.write('json_data/album.json', JSON.generate(musicalbum_data))
  end

  def load_musicalbum_json(musicalbums)
    unless File.exist?('json_data/album.json')
      puts 'No album found.'
      return
    end
    musicalbum_data = JSON.parse(File.read('json_data/album.json'))

    musicalbum_data.each do |ma_data|
      musicalbum = Musicalbum.new(
        ma_data['genre'],
        ma_data['author'],
        ma_data['label'],
        ma_data['publish_date'], # Parse back to DateTime if needed
        ma_data['on_spotify']
      )
      musicalbums << musicalbum
    end

    puts 'Albums loaded successfully!'
  end
end
