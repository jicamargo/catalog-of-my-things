require './Author'
require 'rspec'

describe Author do
  let(:first_name) { 'Jane' }
  let(:last_name) { 'Doe' }

  subject(:author) do
    Author.new(first_name, last_name)
  end

  describe '#initialize' do
    it 'creates a new Author instance' do
      expect(author).to be_instance_of(Author)
    end
  end

  describe '#add_item' do
    it 'adds an item to the author' do
      item = double('item')
      expect { author.add_item(item) }.to change { author.items.size }.by(1)
    end

    it 'associates the author with the added item' do
      item = double('item')
      expect(item).to receive(:author=).with(author)
      author.add_item(item)
    end
  end
end
