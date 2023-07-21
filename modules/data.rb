require 'json'
require_relative 'game'
require_relative 'author'
require_relative 'item'

module DataJson
  def load_games(games)
    return unless File.exist?('./json/games.json')

    games_data = JSON.parse(File.read('./json/games.json'))
    games_data.each do |game|
      games << Game.new(game['publish_date'], game['multiplayer'], game['last_played_at'], id: game['id'])
    end
  end

  def save_games(games)
    File.write('./json/games.json', JSON.pretty_generate(games.map(&:to_hash)))
  end

  def load_authors(authors)
    return unless File.exist?('./json/authors.json')

    authors_data = JSON.parse(File.read('./json/authors.json'))
    authors_data.each do |author|
      authors << Author.new(author['first_name'], author['last_name'], id: author['id'])
    end
  end

  def save_authors(authors)
    File.write('./json/authors.json', JSON.pretty_generate(authors.map(&:to_hash)))
  end

  def save_data(games, authors, items)
    save_games(games)
    save_authors(authors)
  end
end
