require_relative '../class_musicalbum'
require 'date'

RSpec.describe Musicalbum do
  let(:genre) { double('Genre', items: []) }
  let(:author) { double('Author', items: []) }
  let(:label) { double('Label', items: []) }
  let(:publish_date) { Time.now - (12 * 365 * 24 * 60 * 60) } # Older than 10 years

  subject(:album) { described_class.new(genre, author, label, publish_date, on_spotify) }

  describe '#can_be_archived?' do
    context 'when publish_date is older than 10 years and not on Spotify' do
      let(:on_spotify) { false }

      it 'returns true' do
        expect(album.can_be_archived?).to eq(true)
      end
    end

    context 'when publish_date is older than 10 years but on Spotify' do
      let(:on_spotify) { true }

      it 'returns false' do
        expect(album.can_be_archived?).to eq(false)
      end
    end

    context 'when publish_date is not older than 10 years and not on Spotify' do
      let(:publish_date) { Time.now - (5 * 365 * 24 * 60 * 60) } # Less than 10 years
      let(:on_spotify) { false }

      it 'returns false' do
        expect(album.can_be_archived?).to eq(false)
      end
    end
  end
end
