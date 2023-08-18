require_relative '../class_game'
require 'date'

RSpec.describe Game do
  let(:genre) { double('Genre', items: []) }
  let(:author) { double('Author', items: []) }
  let(:label) { double('Label', items: []) }
  let(:publish_date) { Time.now - (10 * 365 * 24 * 60 * 60) } # Older than 10 years

  subject(:game) { described_class.new(genre, author, label, publish_date) }

  describe '#can_be_archived?' do
    context 'when publish_date is older than 10 years but last_played_at is not older than 2 years' do
      before do
        allow(game).to receive(:last_played_at).and_return(Date.today - (1 * 365)) # Less than 2 years
      end

      it 'returns false' do
        expect(game.can_be_archived?).to eq(false)
      end
    end

    context 'when publish_date is not older than 10 years and last_played_at is older than 2 years' do
      let(:publish_date) { Time.now - (1 * 365 * 24 * 60 * 60) } # Less than 10 years

      before do
        allow(game).to receive(:last_played_at).and_return(Date.today - (3 * 365)) # Older than 2 years
      end

      it 'returns false' do
        expect(game.can_be_archived?).to eq(false)
      end
    end

    context 'when publish_date is not older than 10 years and last_played_at is not older than 2 years' do
      let(:publish_date) { Time.now - (1 * 365 * 24 * 60 * 60) } # Less than 10 years

      before do
        allow(game).to receive(:last_played_at).and_return(Date.today - (1 * 365)) # Less than 2 years
      end

      it 'returns false' do
        expect(game.can_be_archived?).to eq(false)
      end
    end
  end
end
