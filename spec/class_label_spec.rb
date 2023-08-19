require_relative '../class_label'
require_relative '../class_labels_handler'
require 'json'

RSpec.describe LabelHandler do
  let(:label_handler) { LabelHandler.new }

  describe '#save_labels' do
    it 'saves labels to the file' do
      labels = [Label.new('Label 1', 'Red'), Label.new('Label 2', 'Blue')]
      label_handler.save_labels(labels)

      data = JSON.parse(File.read(label_handler.instance_variable_get(:@filename)), symbolize_names: true)
      expect(data).to eq([
                           { id: labels[0].id, title: 'Label 1', color: 'Red' },
                           { id: labels[1].id, title: 'Label 2', color: 'Blue' }
                         ])
    end
  end

  describe '#find_create_label' do
    context 'when label exists' do
      it 'returns existing label' do
        existing_label = Label.new('Existing Label', 'Green')
        allow(label_handler).to receive(:load_labels).and_return([existing_label])

        label = label_handler.find_create_label('Existing Label', 'Green')
        expect(label).to eq(existing_label)
      end
    end

    context 'when label does not exist' do
      it 'creates a new label' do
        allow(label_handler).to receive(:load_labels).and_return([])
        allow(label_handler).to receive(:save_labels)

        label = label_handler.find_create_label('New label', 'Yellow')
        expect(label.title).to eq('New label')
        expect(label.color).to eq('Yellow')
      end
    end
  end
end
