require_relative '../modules/author'
require_relative '../modules/item'

describe Author do
  author = Author.new('2010-01-01', 'Larry', 'Villegas')

  describe '#add_item' do
    it 'should add the item to the authors items' do
      item = Item.new('2010-01-01', author.first_name)
      author.add_item(item)
      expect(author.items).to include(item)
    end
  end
end