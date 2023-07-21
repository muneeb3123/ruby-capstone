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
    @items = []
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
    if @games.empty?
      puts 'There is no game in yet!'
    else
      puts 'List of all games:'
      @games.each_with_index do |game, index|
        puts "#{index + 1}.- Is multiplayer: #{game.multiplayer}, Last played at: #{game.last_played_at}"
      end
    end
  end

  def list_all_genres
    list_genre
  end

  def list_all_labels
    @book_manager.display_labels
  end

  def list_all_authors
    if @authors.empty?
      puts 'There is no authors yet!'
    else
      puts 'List of all authors:'
      authors.each_with_index do |author, index|
        puts "#{index + 1}.- ID: #{author.id} First name: #{author.first_name}, Last name: #{author.last_name}"
      end
    end
  end

  def add_a_book
    @book_manager.create_book
  end

  def add_a_music
    new_album = add_new_music_album
    save_music(new_album)
  end

  def add_a_game
    puts 'Enter Game details:'
    print 'Publish date:'
    publish_date = gets.chomp
    print 'Is multiplayer:[y/n] '
    multiplayer = gets.chomp.downcase == 'y'
    print 'Last played at:'
    last_played_at = gets.chomp
    new_game = Game.new(publish_date, multiplayer, last_played_at)
    puts 'Please choose the author by number:'
    list_all_authors
    author_id = gets.chomp.to_i - 1
    new_game.add_author(authors[author_id])
    @games << new_game
    puts 'Game added successfully!'
  end

  def add_a_author
    puts 'Enter Author details:'
    print 'First name: '
    first_name = gets.chomp
    print 'Last name: '
    last_name = gets.chomp
    new_author = Author.new(first_name, last_name)
    authors << new_author
    puts 'Author added successfully!'
  end

  def quit
    save_data(@games, @authors, @items)
    puts 'Thank you for using our app!'
    exit
  end
end
