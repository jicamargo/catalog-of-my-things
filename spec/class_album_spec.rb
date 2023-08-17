require_relative '../class_musicalbum_handler'
require_relative '../class_genre_handler'

RSpec.describe MusicalbumHandler do
  let(:musicalbum_handler) { MusicalbumHandler.new }

  describe '#list_musicalbums' do
    it 'lists music albums' do
      album1 = Musicalbum.new('Rock', 'Author 1', 'Album 1', Time.now, true)
      album2 = Musicalbum.new('Jazz', 'Author 2', 'Album 2', Time.now, false)
      musicalbum_handler.instance_variable_set(:@musicalbums, [album1, album2])

      expected_output = <<~OUTPUT
        List of Music Albums:
        Title: Album 1, Genre: Rock
        Title: Album 2, Genre: Jazz
      OUTPUT

      expect { musicalbum_handler.list_musicalbums }.to output(expected_output).to_stdout
    end
  end

  describe '#add_music_album' do
    context 'when the genre already exists' do
      it 'adds a new music album' do
        allow(musicalbum_handler).to receive(:gets).and_return("Album Title\n", "Rock\n", "y\n")
        genres = [Genre.new('Rock'), Genre.new('Jazz')]
        musicalbum_handler.instance_variable_set(:@genres, genres)

        expect { musicalbum_handler.add_music_album(genres) }.to change { musicalbum_handler.musicalbums.size }.by(1)
        expect(musicalbum_handler.musicalbums.first.label).to eq('Album Title')
        expect(musicalbum_handler.musicalbums.first.genre).to eq('Rock')
        expect(musicalbum_handler.musicalbums.first.on_spotify).to be_truthy
      end
    end

    context 'when the genre does not exist and user adds a new genre' do
      it 'adds a new music album with a new genre' do
        allow(musicalbum_handler).to receive(:gets).and_return("Album Title\n", "New Genre\n", "y\n", "New Genre\n", "y\n")
        genre_handler = GenreHandler.new
        genres = genre_handler.genres
        musicalbum_handler.instance_variable_set(:@genre_handler, genre_handler)

        expect { musicalbum_handler.add_music_album(genres) }.to change { musicalbum_handler.musicalbums.size }.by(1)
        expect(musicalbum_handler.musicalbums.first.label).to eq('Album Title')
        expect(musicalbum_handler.musicalbums.first.genre).to eq('New Genre')
        expect(musicalbum_handler.musicalbums.first.on_spotify).to be_truthy
        expect(genre_handler.genres.size).to eq(1)
      end
    end

    context 'when the genre does not exist and user does not add a new genre' do
      it 'does not add a new music album' do
        allow(musicalbum_handler).to receive(:gets).and_return("Album Title\n", "Nonexistent Genre\n", "n\n")
        genres = [Genre.new('Rock'), Genre.new('Jazz')]
        musicalbum_handler.instance_variable_set(:@genres, genres)

        expect { musicalbum_handler.add_music_album(genres) }.not_to(change { musicalbum_handler.musicalbums.size })
      end
    end
  end
end
