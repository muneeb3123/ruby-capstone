require_relative '../modules/genre'
require_relative '../modules/item'

RSpec.describe Genre do
  describe '#add_item' do
    it 'should add the input item to the collection of items' do
      genre = Genre.new('Rock', 'Genre for rock music')
      item = Item.new('2020-01-05')

      genre.add_item(item)

      expect(genre.items).to include(item)
    end
  end
end