require_relative '../class_genres_handler'
require 'json'

RSpec.describe GenreHandler do
  let(:genre_handler) { GenreHandler.new }

  describe '#input_new_genre' do
    it 'adds a new genre to the genres array' do
      allow(genre_handler).to receive(:gets).and_return("New Genre\n")
      expect { genre_handler.input_new_genre }.to change { genre_handler.genres.size }.by(1)
      expect(genre_handler.genres.first.name).to eq('New Genre')
    end
  end

  describe '#load_genres' do
    it 'loads genres from the file' do
      expected_data = [{ id: 1, name: 'Rock' }, { id: 2, name: 'Jazz' }]
      allow(genre_handler).to receive(:read_json_file).and_return(expected_data)

      genres = genre_handler.load_genres
      expect(genres.size).to eq(2)
      expect(genres.first.name).to eq('Rock')
      expect(genres.last.name).to eq('Jazz')
    end
  end

  describe '#save_genres' do
    it 'saves genres to the file' do
      genres = [Genre.new('Rock'), Genre.new('Jazz')]
      allow(File).to receive(:write)

      genre_handler.save_genres(genres)
      expect(File).to have_received(:write).with(kind_of(String), kind_of(String))
    end
  end

  describe '#find_create_genre' do
    it 'finds an existing genre by name' do
      genres = [Genre.new('Rock'), Genre.new('Jazz')]
      allow(genre_handler).to receive(:load_genres).and_return(genres)

      existing_genre = genre_handler.find_create_genre('Rock')
      expect(existing_genre.name).to eq('Rock')
    end

    it 'creates a new genre if it does not exist' do
      genres = []
      allow(genre_handler).to receive(:load_genres).and_return(genres)

      new_genre = genre_handler.find_create_genre('New genre')
      expect(new_genre.name).to eq('New genre')
    end
  end
end
