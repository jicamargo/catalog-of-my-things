<<<<<<< HEAD
require_relative '../class_books_handler'
require_relative '../class_genres_handler'
require_relative '../class_labels_handler'
require_relative '../class_authors_handler'

RSpec.describe BookHandler do
  let(:book_handler) { BookHandler.new }

  describe '#load_books' do
    it 'loads and returns an array of books' do
      # Mock the read_json_file method to return sample data
      arr_data = [
        { genre: { id: 1, name: 'Fiction' },
          author: { id: 1, first_name: 'John', last_name: 'Doe' },
          label: { id: 1, title: 'Sci-Fi', color: 'Blue' },
          publish_date: '2023-01-01', id: 1, cover_state: 'Good',
          publisher: 'Publisher A',
          archived: false }
      ]
      allow(book_handler).to receive(:read_json_file).and_return(arr_data)
      books = book_handler.load_books
      expect(books.length).to eq(1)
      expect(books.first).to be_a(Book)
      expect(books.first.genre).to be_a(Genre)
      expect(books.first.author).to be_a(Author)
      expect(books.first.label).to be_a(Label)
    end
  end

  describe '#valid_input?' do
    it 'returns true when all inputs are valid' do
      expect(book_handler.valid_input?('Fiction', 'John', 'Sample Title')).to be true
    end

    it 'returns false when any input is empty' do
      expect(book_handler.valid_input?('', 'John', 'Sample Title')).to be false
      expect(book_handler.valid_input?('Fiction', '', 'Sample Title')).to be false
      expect(book_handler.valid_input?('Fiction', 'John', '')).to be false
    end
  end

  describe '#find_create_genre' do
    # Mock the GenreHandler class to return a genre
    let(:genre_handler) { instance_double('GenreHandler') }
    let(:genre) { Genre.new('Fiction') }

    it 'returns an existing genre' do
      allow(GenreHandler).to receive(:new).and_return(genre_handler)
      allow(genre_handler).to receive(:find_create_genre).and_return(genre)

      result = book_handler.find_create_genre('Fiction')
      expect(result).to eq(genre)
    end
  end

  describe '#find_create_label' do
    # Mock the LabelHandler class to return a label
    let(:label_handler) { instance_double('LabelHandler') }
    let(:label) { Label.new('Sample Title', 'Blue') }

    it 'returns an existing label' do
      allow(LabelHandler).to receive(:new).and_return(label_handler)
      allow(label_handler).to receive(:find_create_label).and_return(label)

      result = book_handler.find_create_label('Sample Title', 'Blue')
      expect(result).to eq(label)
    end
  end

  describe '#find_create_author' do
    # Mock the AuthorHandler class to return an author
    let(:author_handler) { instance_double('AuthorHandler') }
    let(:author) { Author.new('John', 'Doe') }

    it 'returns an existing author' do
      allow(AuthorHandler).to receive(:new).and_return(author_handler)
      allow(author_handler).to receive(:find_create_author).and_return(author)

      result = book_handler.find_create_author('John', 'Doe')
      expect(result).to eq(author)
=======
require './class_book'
require './class_item'

describe Book do
  context 'when using the can_be_archive? method with a cover_state = "bad" ' do
    it 'returns true when cover_state = "bad" or method from item class returns true' do
      book = Book.new('In the house', 'bad', 2012)
      expect(book.send(:can_be_archived?)).to be true
    end
  end

  context 'when using the can_be_archive? method with a cover_state = "good" ' do
    it 'returns false when cover_state != "bad" and if method from item class returns false' do
      book2 = Book.new('In the house', 'good', 2023)
      expect(book2.send(:can_be_archived?)).to be false
>>>>>>> 687654a5e18f8fb1e417dbf29fcda55aadea9bee
    end
  end
end
