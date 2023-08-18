require_relative 'app'
require_relative 'class_genre'
require_relative 'class_musicalbum'
require_relative 'class_author'
require_relative 'class_label'
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
    return if musicalbums.nil? || musicalbums.empty?

    musicalbum_data = musicalbums.map do |music_album|
      {
        id: music_album.id,
        genre: { id: music_album.genre.id, name: music_album.genre.name },
        label: { id: music_album.label.id, title: music_album.label.title, color: music_album.label.color },
        author: { id: music_album.author.id, first_name: music_album.author.first_name, last_name: music_album.author.last_name },
        publish_date: music_album.publish_date.to_s,
        on_spotify: music_album.on_spotify
      }
    end
<<<<<<< HEAD
    File.write('json_data/album.json', JSON.pretty_generate(musicalbum_data))
=======

    puts 'Saving album data:'
    puts musicalbum_data.inspect

    File.write('json_data/album.json', JSON.generate(musicalbum_data))
>>>>>>> 687654a5e18f8fb1e417dbf29fcda55aadea9bee
  end

  def load_musicalbum_json(musicalbums)
    unless File.exist?('json_data/album.json')
      puts 'No album found.'
      return
    end
    musicalbum_data = JSON.parse(File.read('json_data/album.json'), symbolize_names: true)

    musicalbum_data.each do |ma_data|
      genre = Genre.new(ma_data[:genre][:name])
      genre.id = ma_data[:genre][:id]
      label = Label.new(ma_data[:label][:title], ma_data[:label][:color])
      label.id = ma_data[:label][:id]
      author = Author.new(ma_data[:author][:first_name], ma_data[:author][:last_name])
      author.id = ma_data[:author][:id]

      musicalbum = Musicalbum.new(
        ma_data[:genre],
        ma_data[:author],
        ma_data[:label],
        Date.parse(ma_data[:publish_date]),
        ma_data[:on_spotify]
      )

      musicalbum.id = ma_data[:id]
      musicalbum.genre = genre
      musicalbum.label = label
      musicalbum.author = author
      # musicalbum = Musicalbum.new(
      #   ma_data['genre'],
      #   ma_data['author'],
      #   ma_data['label'],
      #   ma_data['publish_date'], # Parse back to DateTime if needed
      #   ma_data['on_spotify']
      # )

      musicalbums << musicalbum
    end

    puts 'Albums loaded successfully!'
  end
end
