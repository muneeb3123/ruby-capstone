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
  10 => 'Add a Author',
  0 => 'Quit'
}.freeze

ACTIONS = {
  1 => :list_all_books,
  2 => :list_all_music,
  3 => :list_all_games,
  4 => :list_all_genres,
  5 => :list_all_labels,
  6 => :list_all_authors,
  7 => :add_a_book,
  8 => :add_a_music,
  9 => :add_a_game,
  10 => :add_a_author,
  0 => :quit
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

def method_choice(option, instance_app)
  action = ACTIONS[option]
  if action
    instance_app.send(action)
  else
    puts 'Wrong option! Please try again.'
  end
  !option.zero?
end

def main
  instance_app = App.new
  display_welcome_message

  loop do
    display_options
    option = ask_for_option
    puts OPTIONS[option] if option.between?(1, 10)
    break unless method_choice(option, instance_app)

    puts '========================================================'
  end
end

main
