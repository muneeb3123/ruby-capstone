require_relative '../author'
require_relative 'book'
require_relative '../genre/genre'
require_relative 'label'

class BookManager
  def initialize
    @books = load_book_from_json
    @labels = load_labels_from_json
  end

  def create_book
    user_input
    book = Book.new(@publish_date, @publisher, @cover_state)
    label = Label.new(@title, @color)
    author = Author.new(@first_name, @last_name)
    genre = Genre.new(@genre, @description)
    book.add_label(label)
    book.add_author(author)
    book.add_genre(genre)
    @labels << label
    @books << book
    save_book_to_json
    save_labels_to_json
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

  def save_book_to_json
    json_array = @books.map do |book|
      author_obj = build_author_json(book.author)
      label_obj = build_label_json(book.label)
      genre_obj = build_genre_json(book.genre)

      {
        id: book.id,
        author: author_obj,
        label: label_obj,
        genre: genre_obj,
        publisher: book.publisher,
        cover_state: book.cover_state,
        publish_date: book.publish_date
      }
    end

    json = JSON.pretty_generate(json_array)
    File.write('modules/book-label/book.json', json)
  end

  def load_book_from_json
    if File.exist?('modules/book-label/book.json')
      json_data = File.read('modules/book-label/book.json')
      if json_data.empty?
        @books = []
      else
        new_books = JSON.parse(json_data).map do |book_data|
          book = Book.new(book_data['publish_date'], book_data['publisher'], book_data['cover_state'])
          label = Label.new(book_data['label']['title'], book_data['label']['color'])
          author = Author.new(book_data['author']['first_name'], book_data['author']['last_name'])
          genre = Genre.new(book_data['genre']['name'], book_data['genre']['description'])
          book.add_label(label)
          book.add_author(author)
          book.add_genre(genre)
          book
        end
        @books = new_books
      end
    else
      @books = []
    end
  end

  def save_labels_to_json
    json_array = @labels.map do |label|
      {
        id: label.id,
        title: label.title,
        color: label.color
      }
    end

    json = JSON.pretty_generate(json_array)
    File.write('modules/book-label/labels.json', json)
  end

  def load_labels_from_json
    if File.exist?('modules/book-label/labels.json')
      json_data = File.read('modules/book-label/labels.json')
      if json_data.empty?
        @labels = []
      else
        new_labels = JSON.parse(json_data).map do |label_data|
          label = Label.new(label_data['title'], label_data['color'])
          label.instance_variable_set(:@id, label_data['id'])
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

  def build_author_json(author)
    {
      id: author.id,
      first_name: author.first_name,
      last_name: author.last_name
    }
  end

  def build_label_json(label)
    {
      id: label.id,
      title: label.title,
      color: label.color
    }
  end

  def build_genre_json(genre)
    {
      id: genre.id,
      name: genre.name,
      description: genre.description
    }
  end

  def prompt_user_input(prompt)
    print prompt
    gets.chomp
  end
end
