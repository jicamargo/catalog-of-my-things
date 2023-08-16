require_relative '../class_games_handler'
require_relative '../class_author'
require_relative '../class_game'
require_relative '../date_validator'

RSpec.describe GameHandler do
  let(:author_handler) { AuthorHandler.new }
  let(:game_handler) { GameHandler.new }

  before(:each) do
    File.write('json_data/authors.json', '')
    File.write('json_data/games.json', '')
  end

  describe '#input_genre' do
    it 'reads genre from user input' do
      allow(game_handler).to receive(:gets).and_return('Adventure')
      expect(game_handler.input_genre).to eq('Adventure')
    end
  end

  describe '#input_author' do
    it 'reads author name from user input' do
      allow(game_handler).to receive(:gets).and_return("John Doe\n")
      expect(game_handler.input_author).to eq(['John', 'Doe'])
    end
  end

  describe '#valid_input?' do
    it 'returns true for valid inputs' do
      expect(game_handler.valid_input?('Action', 'John', 'Game')).to be_truthy
    end

    it 'returns false for empty genre' do
      expect(game_handler.valid_input?('', 'John', 'Game')).to be_falsy
    end

    it 'returns false for empty author' do
      expect(game_handler.valid_input?('Action', '', 'Game')).to be_falsy
    end

    it 'returns false for empty label' do
      expect(game_handler.valid_input?('Action', 'John', '')).to be_falsy
    end
  end

  describe '#create_game' do
    it 'creates a new game' do
      author = Author.new('John', 'Doe')
      game = game_handler.create_game('Action', author, 'Game', Date.today)
      expect(game).to be_a(Game)
      expect(game.genre).to eq('Action')
      expect(game.author).to eq(author)
      expect(game.label).to eq('Game')
      expect(game.publish_date).to eq(Date.today)
    end
  end

  describe '#save_game' do
    it 'saves a game' do
      allow(game_handler).to receive(:load_games).and_return([])
      game = Game.new('Action', Author.new('John', 'Doe'), 'Game', Date.today)
      expect(game_handler).to receive(:save_games).with([game])
      game_handler.save_game(game)
    end
  end

  describe '#list_games' do
    it 'lists all games' do
      allow(game_handler).to receive(:load_games).and_return([
        Game.new('Action', Author.new('John', 'Doe'), 'Game', Date.today)
      ])
      expect { game_handler.list_games }.to output(/John Doe/).to_stdout
    end
  end  
end
