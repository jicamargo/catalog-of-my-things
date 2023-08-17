require_relative '../class_genre_handler'

RSpec.describe GenreHandler do
  let(:genre_handler) { GenreHandler.new }

  describe '#input_new_genre' do
    it 'adds a new genre' do
      input = "Pop\n"
      allow_any_instance_of(Object).to receive(:gets).and_return(input)

      genre_handler.input_new_genre

      expect(genre_handler.genres.size).to eq(1)
      expect(genre_handler.genres.first.name).to eq('Pop')
    end
  end

  describe '#list_genres' do
    it 'lists genres' do
      genre1 = Genre.new('Rock')
      genre2 = Genre.new('Jazz')
      genre_handler.instance_variable_set(:@genres, [genre1, genre2])

      expect { genre_handler.list_genres }.to output("Genres list:\nRock\nJazz\n").to_stdout
    end
  end
end
