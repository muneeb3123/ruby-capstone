require_relative 'modules/data'
require_relative 'modules/game'
require_relative 'modules/author'

class App
  attr_reader :games, :authors

  include DataJson

  def initialize
    @games = []
    @authors = []
    load_authors(@authors)
    load_games(@games)
  end

  def list_all_books
    puts 'call the method list_all_books'
  end

  def list_all_music
    puts 'call the method list_all_music'
  end

  def list_all_games
    puts 'call the method list_all_games'
  end

  def list_all_genres
    puts 'call the method list_all_genres'
  end

  def list_all_labels
    puts 'call the method list_all_labels'
  end

  def list_all_authors
    puts 'call the method list_all_authors'
  end

  def add_a_book
    puts 'call the method add_a_book'
  end

  def add_a_music
    puts 'call the method add_a_music'
  end

  def add_a_game
    puts 'call the method add_a_game'
  end

  def quit
    save_data(@games, @authors)
    puts 'Thank you for using our app!'
    exit
  end
end
