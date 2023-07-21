class Genre
  attr_accessor :name, :description, :items

  def initialize(name, description)
    @name = name
    @description = description
    @items = []
  end

  def add_item(item)
    @items << item
  end
end
