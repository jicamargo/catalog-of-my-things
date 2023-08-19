require_relative '../class_musicalbum_handler'
require_relative '../class_genres_handler'

RSpec.describe MusicalbumHandler do
  let(:musicalbum_handler) { MusicalbumHandler.new }

  describe '#list_musicalbums' do
    it 'lists music albums' do
      album1 = instance_double(Musicalbum, id: 1, label: instance_double(Label, title: 'Album 1'), genre: instance_double(Genre, name: 'Rock'), on_spotify: true)
      musicalbum_handler.instance_variable_set(:@musicalbums, [album1])
      expect { musicalbum_handler.list_musicalbums }.to output(/Album 1/).to_stdout
    end
  end

  describe '#input_author' do
    it 'returns an array with first name and last name' do
      allow(musicalbum_handler).to receive(:gets).and_return("John Doe\n")
      expect(musicalbum_handler.input_author).to eq(%w[John Doe])
    end

    it 'returns an array with only first name if last name is not provided' do
      allow(musicalbum_handler).to receive(:gets).and_return("Jane\n")
      expect(musicalbum_handler.input_author).to eq(['Jane', ''])
    end
  end

  describe '#genre_validator' do
    it 'adds a new genre and returns its name' do
      allow(musicalbum_handler).to receive(:gets).and_return("New Genre\n")
      genres = []
      expect(musicalbum_handler.genre_validator(genres)).to eq('New Genre')
      expect(genres.size).to eq(1)
      expect(genres.first.name).to eq('New Genre')
    end
  end
end
