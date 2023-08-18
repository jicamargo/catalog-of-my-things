require './class_label'

describe Label do
  context 'when using the add_item method' do
    it 'creates a label with title, color' do
      label = Label.new('Love within', 'red')
      expect(label.title).to eq('Love within')
      expect(label.color).to eq('red')
      expect(label.items).to eq([])
    end
  end

  describe '#add_item' do
    it 'adds an item to the label' do
      label = Label.new('Love within', 'red')
      item = double('Item')
      allow(item).to receive(:add_label)
      label.add_item(item)
      expect(label.items).to eq([item])
      expect(item).to have_received(:add_label).with(label)
    end
  end
end
