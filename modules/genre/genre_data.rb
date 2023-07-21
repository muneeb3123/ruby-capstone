require 'json'

module GenreData
  def save_genre(genres)
    File.open('./genres.json', 'w') do |file|
      json_data = genres.map do |genre|
        {
          name: genre.name,
          description: genre.description,
          items: genre.items.map(&:to_hash)
        }
      end
      file.write(JSON.pretty_generate(json_data))
    end
  end

  def load_genre(_genres)
    return unless File.exist?('./genres.json')

    json_data = JSON.parse(File.read('./genres.json'))
    json_data.map do |genre_data|
      genre = Genre.new(genre_data['name'], genre_data['description'])
      genre_data['items'].each do |item_data|
        item = Item.new(item_data['title'], Date.parse(item_data['publish_date']))
        item.genre = genre
        genre.add_item(item)
      end
      genre
    end
  end

  def list_genre
    puts '========================================================'
    return puts 'The genres list is empty' unless File.exist?('./genres.json')

    genres = []

    json_data = JSON.parse(File.read('./genres.json'))

    json_data.each do |genre_data|
      genre = Genre.new(genre_data['name'], genre_data['description'])
      genre_data['items'].each do |item_data|
        item = Item.new(item_data['title'], Date.parse(item_data['publish_date']))
        item.genre = genre
        genre.add_item(item)
      end
      genres << genre
    end

    puts 'All Genres:'
    genres.each do |genre|
      puts "Name: #{genre.name}"
      puts "Description: #{genre.description}"
      puts "Items Count: #{genre.items.length}"
      puts '-' * 30
    end
  end
end
