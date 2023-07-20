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

  def save_genre(genres)
    File.open(genres, 'w') do |_genre|
      json_data = {
        name: @name,
        description: @description,
        items: @items.map(&:to_json)
      }
      File.write('../json/genres.json', JSON.generate(json_data))
    end
  end
end
