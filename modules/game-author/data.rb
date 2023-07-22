require 'json'
require_relative 'game'
require_relative 'author'
require './modules/item'

module DataJson
  def load_games(games)
    return unless File.exist?('modules/game-author/game.json')

    games_data = JSON.parse(File.read('modules/game-author/game.json'))
    games_data.each do |game|
      games << Game.new(game['publish_date'], game['multiplayer'], game['last_played_at'], id: game['id'])
    end
  end

  def save_games(games)
    File.write('modules/game-author/game.json', JSON.pretty_generate(games.map(&:to_hash)))
  end

  def load_authors(authors)
    return unless File.exist?('modules/game-author/author.json')

    authors_data = JSON.parse(File.read('modules/game-author/author.json'))
    authors_data.each do |author|
      authors << Author.new(author['first_name'], author['last_name'], id: author['id'])
    end
  end

  def save_authors(authors)
    File.write('modules/game-author/author.json', JSON.pretty_generate(authors.map(&:to_hash)))
  end
end
