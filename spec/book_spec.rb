require_relative '../modules/book-label/book'

describe Book do
  it 'should initialize class and instance variable' do
    book = Book.new(Date.parse('2012-12-12'), 'oxfoard', 'good', 45, 'label', 'fiction')
    expect(book).to have_attributes(publisher: 'oxfoard', publish_date: Date.parse('2012-12-12'), cover_state: 'good')
  end

  context 'when cover state is bad' do
    it 'returns true' do
      book = Book.new(Date.parse('2012-12-12'), 'oxfoard', 'bad', 45, 'label', 'fiction')
      expect(book.can_be_archived?).to be true
    end
  end

  context 'when cover state is good' do
    it 'returns false' do
      book = Book.new(Date.parse('2019-12-12'), 'oxfoard', 'good', 45, 'label', 'fiction')
      expect(book.can_be_archived?).to be false
    end
  end
end
