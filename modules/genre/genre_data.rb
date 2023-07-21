require 'json'

module GenreData
  def save_genre(genres)
    File.open('modules/genre/genres.json', 'w') do |file|
      json_data = genres.map do |genre|
        {
          name: genre.name,
          description: genre.description
        }
      end
      file.write(JSON.pretty_generate(json_data))
    end
  end

  def load_genre(_genres)
    return unless File.exist?('modules/genre/genres.json')

    json_data = JSON.parse(File.read('modules/genre/genres.json'))
    json_data.map do |genre_data|
      Genre.new(genre_data['name'], genre_data['description'])
    end
  end

  def list_genre
    puts '========================================================'
    return puts 'The genres list is empty' unless File.exist?('modules/genre/genres.json')

    genres = []
    json_data = JSON.parse(File.read('modules/genre/genres.json'))

    json_data.each do |genre_data|
      genre = Genre.new(genre_data['name'], genre_data['description'])
      genres << genre
    end

    puts 'All Genres:'
    genres.each do |genre|
      puts "Name: #{genre.name}"
      puts "Description: #{genre.description}"
      puts '-' * 30
    end
  end
end
