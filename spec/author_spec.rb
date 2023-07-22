require_relative '../modules/game-author/author'
require_relative '../modules/item'

describe Author do
  author = Author.new('Larry', 'Villegas')

  describe '#add_item' do
    it 'should add the item to the authors items' do
      item = Item.new('2010-01-01')
      author.add_item(item)
      expect(author.items).to include(item)
    end
  end
end
