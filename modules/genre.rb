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

  def load_genre(genres)
    return unless File.exist?(genres)

    json_data = JSON.parse(File.read('../json/genres.json'))
    genre = Genre.new(json_data[genre], json_data['description'])
    json_data['items'].each do |item_data|
      item = Item.new(item_data['title'], Date.parse(item_data['published_date']))
      item.genre = genre
      genre.add_item(item)
    end
    genre
  end
end
