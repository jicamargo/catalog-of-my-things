require_relative '../class_item'

RSpec.describe Item do
  let(:genre) { double('Genre', items: []) }
  let(:author) { double('Author', items: []) }
  let(:label) { double('Label', items: []) }
  let(:publish_date) { Time.now - 11 * 365 * 24 * 60 * 60 } # Older than 10 years

  subject(:item) { described_class.new(genre, author, label, publish_date) }

  describe '#can_be_archived?' do
    context 'when publish_date is older than 10 years' do
      it 'returns true' do
        expect(item.can_be_archived?).to eq(true)
      end
    end

    context 'when publish_date is not older than 10 years' do
      let(:publish_date) { Time.now - 9 * 365 * 24 * 60 * 60 } # Less than 10 years

      it 'returns false' do
        expect(item.can_be_archived?).to eq(false)
      end
    end
  end

  describe '#move_to_archive' do
    context 'when can_be_archived? returns true' do
      before do
        allow(item).to receive(:can_be_archived?).and_return(true)
      end

      it 'archives the item' do
        item.move_to_archive
        expect(item.archived).to eq(true)
      end
    end

    context 'when can_be_archived? returns false' do
      before do
        allow(item).to receive(:can_be_archived?).and_return(false)
      end

      it 'does not archive the item' do
        item.move_to_archive
        expect(item.archived).to eq(false)
      end
    end
  end
end
