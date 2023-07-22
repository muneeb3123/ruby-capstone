require_relative '../game-author/author'
require_relative 'book'
require_relative '../genre/genre'
require_relative 'label'
require_relative 'data_manager'

class BookManager
  include DataManager

  def initialize
    @books = load_book_from_json
    @labels = load_labels_from_json
    @authors = []
    @genres = []
  end

  def create_book
    user_input
    label = Label.new(@title, @color)
    author = Author.new(@first_name, @last_name)
    genre = Genre.new(@genre, @genre_description)
    book = Book.new(@publish_date, @publisher, @cover_state)
    book.add_label(label)
    book.add_author(author)
    book.add_genre(genre)
    @labels << label
    @books << book
    @genres << genre
    @authors << author
    save_data_to_json(@books, 'modules/book-label/book.json')
    save_data_to_json(@authors, 'modules/game-author/author.json')
    save_data_to_json(@labels, 'modules/book-label/labels.json')
    save_data_to_json(@genres, 'modules/genre/genres.json')
    puts "successfully created  #{@title} by #{@first_name} #{@last_name}"
  end

  def display_books
    if @books.empty?
      puts 'There is no book please add a book'
    else
      @books.each_with_index do |book, index|
        puts '-' * 80
        puts "#{index + 1}. Book: #{index + 1}  ID: #{book.id}"
        puts "   Title: #{book.label.title}"
        puts "   Author: #{book.author.first_name} #{book.author.last_name}"
        puts "   Genre: #{book.genre.name}"
        puts "   Published Date: #{book.publish_date}"
        puts "   Publisher: #{book.publisher}"
        puts "   Cover State: #{book.cover_state}"
        puts '-' * 80
      end
    end
  end

  def display_labels
    if @labels.empty?
      puts 'there is no label'
    else
      @labels.each_with_index do |label, index|
        puts "#{index}): Title: #{label.title}, Color: #{label.color}"
      end
    end
  end

  def load_book_from_json
    if File.exist?('modules/book-label/book.json')
      json_data = File.read('modules/book-label/book.json')
      @books = if json_data.empty?
                 []
               else
                 JSON.parse(json_data).map do |book_data|
                   label = Label.new(book_data['label']['title'], book_data['label']['color'])
                   author = Author.new(book_data['author']['first_name'], book_data['author']['last_name'])
                   genre = Genre.new(book_data['genre']['name'], book_data['genre']['description'])
                   book = Book.new(book_data['publish_date'], book_data['publisher'], book_data['cover_state'])
                   book.add_label(label)
                   book.add_author(author)
                   book.add_genre(genre)
                   book
                 end
               end
    else
      @books = []
    end
  end

  def load_labels_from_json
    if File.exist?('modules/book-label/labels.json')
      json_data = File.read('modules/book-label/labels.json')
      if json_data.empty?
        @labels = []
      else
        new_labels = JSON.parse(json_data).map do |label_data|
          label = Label.new(label_data['title'], label_data['color'], id: label_data['id'])
          label
        end
        @labels = new_labels
      end
    else
      @labels = []
    end
  end

  private

  def user_input
    @title = prompt_user_input('Enter book title: ')
    @first_name = prompt_user_input('Enter first name of author: ')
    @last_name = prompt_user_input('Enter last name of author: ')
    @genre = prompt_user_input('Enter book genre: ')
    @genre_description = prompt_user_input('Enter genre_description: ')
    @publish_date = prompt_user_input('Enter the published date (YYYY-MM-DD): ')
    @color = prompt_user_input('Enter book color: ')
    @publisher = prompt_user_input('Enter book publisher: ')
    @cover_state = prompt_user_input('Is the book cover state "Good" or "Bad"?: ')
  end

  def prompt_user_input(prompt)
    print prompt
    gets.chomp
  end
end
