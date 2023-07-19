require_relative 'item'

class Author < Item
  attr_accessor :first_name, :last_name
  attr_reader :items

  def initialize(publish_date, first_name, last_name, id: rand(1..1000))
    super(publish_date)
    @id = id
    @first_name = first_name
    @last_name = last_name
    @items = []
  end

  def add_item(item)
    @items << item
    item.add_author(self)
  end
end
