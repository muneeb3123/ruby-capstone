class Label
  attr_accessor :title, :color
  attr_reader :items, :id

  def initialize(title, color, id: rand(1..1000))
    @id = id
    @title = title
    @color = color
    @items = []
  end

  def add_item(item)
    @items << item
    item.add_label(self)
  end

  def to_hash
    {
      title: @title,
      color: @color,
      id: @id
    }
  end
end
