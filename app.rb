require_relative 'modules/data'
require_relative 'modules/game'
require_relative 'modules/author'
require_relative 'modules/genre/genre'
require_relative 'modules/genre/genre_data'
require_relative 'modules/music/music'
require_relative 'modules/music/music_data'
require_relative 'modules/book-label/book_manager'

class App
  attr_reader :games, :authors

  include DataJson
  include GenreData
  include MusicData

  def initialize
    @games = []
    @authors = []
    load_authors(@authors)
    load_games(@games)
    @book_manager = BookManager.new
  end

  def list_all_books
    @book_manager.display_books
  end

  def list_all_music
    list_music
  end

  def list_all_games
    puts 'call the method list_all_games'
  end

  def list_all_genres
    list_genre
  end

  def list_all_labels
    @book_manager.display_labels
  end

  def list_all_authors
    puts 'call the method list_all_authors'
  end

  def add_a_book
    @book_manager.create_book
  end

  def add_a_music
    new_album = add_new_music_album
    save_music(new_album)
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
