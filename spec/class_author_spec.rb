require_relative '../class_authors_handler'
require_relative '../class_author'

RSpec.describe AuthorHandler do
  let(:author_handler) { AuthorHandler.new }

  describe '#load_authors' do
    it 'returns an array of authors when the file exists' do
      # Create a mock authors.json file with some data
      allow(File).to receive(:exist?).and_return(true)
      allow(File).to receive(:read).and_return('[{"first_name": "John", "last_name": "Doe"}]')

      authors = author_handler.load_authors
      expect(authors.size).to eq(1)
      expect(authors.first).to be_an_instance_of(Author)
    end
  end

  describe '#save_authors' do
    it 'saves authors to the file' do
      # Create a mock authors array
      authors = [Author.new('John', 'Doe')]

      # Use a temporary file to capture the written content
      tmp_filename = 'tmp_authors.json'
      author_handler.instance_variable_set(:@filename, tmp_filename)

      author_handler.save_authors(authors)

      # Read the temporary file and compare its content
      saved_data = JSON.parse(File.read(tmp_filename), symbolize_names: true)
      expect(saved_data[0][:first_name]).to eq('John')
      expect(saved_data[0][:last_name]).to eq('Doe')
      expect(saved_data[0][:id]).to match(/\h{8}-\h{4}-\h{4}-\h{4}-\h{12}/)

      # Clean up the temporary file
      File.delete(tmp_filename)
    end
  end

  describe '#find_create_author' do
    it 'finds and returns an existing author' do
      # Create a mock authors array
      authors = [Author.new('John', 'Doe')]
      allow(author_handler).to receive(:load_authors).and_return(authors)

      existing_author = author_handler.find_create_author('John', 'Doe')
      expect(existing_author).to be_an_instance_of(Author)
      expect(existing_author.first_name).to eq('John')
      expect(existing_author.last_name).to eq('Doe')
    end

    it 'creates a new author if not found' do
      allow(author_handler).to receive(:load_authors).and_return([])
      new_author = author_handler.find_create_author('Jane', 'Smith')

      expect(new_author).to be_an_instance_of(Author)
      expect(new_author.first_name).to eq('Jane')
      expect(new_author.last_name).to eq('Smith')
    end
  end
end
