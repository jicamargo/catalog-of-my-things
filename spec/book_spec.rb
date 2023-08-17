require './book'
# require './add_items'

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
    end
  end
end
