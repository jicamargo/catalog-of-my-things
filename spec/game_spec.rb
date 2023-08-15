require './Game'
require 'rspec'

describe Game do
  let(:genre) { 'Action' }
  let(:author) { 'John Doe' }
  let(:label) { 'Game Studios' }
  let(:publish_date) { Date.new(2023, 1, 1) }
  let(:multiplayer) { true }
  let(:last_played_at) { Date.new(2023, 8, 1) }

  subject(:game) do
    Game.new(genre, author, label, publish_date, multiplayer, last_played_at)
  end

  describe '#initialize' do
    it 'creates a new Game instance' do
      expect(game).to be_instance_of(Game)
    end
  end

  describe '#can_be_archived?' do
    it 'returns true if the game is not archived' do
      expect(game.can_be_archived?).to eq(true)
    end
  end

  describe '#move_to_archive' do
    it 'archives the game' do
      game.move_to_archive
      expect(game.archived).to eq(true)
    end
  end
end
