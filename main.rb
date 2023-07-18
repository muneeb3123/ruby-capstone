require_relative 'app'

OPTIONS = {
  1 => 'List all books',
  2 => 'List all Music',
  3 => 'List all Games',
  4 => 'List all Genres',
  5 => 'List all Labels',
  6 => 'List all Authors',
  7 => 'Add a book',
  8 => 'Add a Music',
  9 => 'Add a Game',
  10 => 'Quit'
}.freeze

def display_options
  OPTIONS.each do |key, value|
    puts "#{key}. #{value}"
  end
end

def display_welcome_message
  puts 'Welcome to "Catalogue of my things"'
end

def ask_for_option
  puts 'Please choose an option by number: '
  gets.chomp.to_i
end

def main
  instance_app = App.new
  display_welcome_message

  loop do
    display_options
    option = ask_for_option
    puts OPTIONS[option] if option.between?(1, 10)
    case option
    when 1
      instance_app.list_all_books
    when 2
      instance_app.list_all_music
    when 3
      instance_app.list_all_games
    when 4
      instance_app.list_all_genres
    when 5
      instance_app.list_all_labels
    when 6
      instance_app.list_all_authors
    when 7
      instance_app.add_a_book
    when 8
      instance_app.add_a_music
    when 9
      instance_app.add_a_game
    when 10
      break
    else
      puts 'Wrong option! Please try again.'
    end
    puts '========================================================'
  end
  puts 'Thank you for using our app!'
end

main
