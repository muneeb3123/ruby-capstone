class Genre
  attr_accessor :name, :description, :items, :id

  def initialize(name, description, id: rand(1..1000))
    @name = name
    @id = id
    @description = description
    @items = []
  end

  def add_item(item)
    @items << item
  end
end
