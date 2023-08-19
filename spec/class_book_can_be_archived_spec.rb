require_relative '../class_book'
require 'date'

RSpec.describe Book do
  let(:genre) { double('Genre', items: []) }
  let(:author) { double('Author', items: []) }
  let(:label) { double('Label', items: []) }
  let(:publish_date) { Time.now - (12 * 365 * 24 * 60 * 60) } # Older than 10 years

  subject(:book) { described_class.new(genre, author, label, publish_date) }

  describe '#can_be_archived?' do
    context 'when publish_date is older than 10 years and cover_state is good' do
      let(:cover_state) { 'good' }

      it 'returns true' do
        expect(book.can_be_archived?).to eq(true)
      end
    end

    context 'when publish_date is older than 10 years and cover_state is bad' do
      let(:cover_state) { 'bad' }

      it 'returns true' do
        expect(book.can_be_archived?).to eq(true)
      end
    end

    context 'when publish_date is not older than 10 years and cover_state is good' do
      let(:publish_date) { Time.now - (5 * 365 * 24 * 60 * 60) } # Less than 10 years
      let(:cover_state) { 'good' }

      it 'returns false' do
        expect(book.can_be_archived?).to eq(false)
      end
    end
  end
end
