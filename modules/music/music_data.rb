require_relative 'music'
require 'json'

module MusicData
  def save_music(music)
    music_albums = []
    if File.size?('./modules/music/music.json').nil?
      File.open('./modules/music/music.json', 'w')
    else
      data = File.read('./modules/music/music.json')
      music_albums = JSON.parse(data)
    end

    music_albums.push({
                        'title' => music.title,
                        'publish_date' => music.publish_date.to_s,
                        'artist' => music.artist,
                        'total_tracks' => music.total_tracks,
                        'on_spotify' => music.on_spotify,
                        'genre' => music.genre&.to_hash
                      })

    File.write('./modules/music/music.json', JSON.pretty_generate(music_albums))
  end

  def load_music(music_album)
    json_data = JSON.parse(File.read(music_album))
    music_album = MusicAlbum.new(
      json_data['title'],
      Date.parse(json_data['publish_date']),
      json_data['artist'],
      json_data['total_tracks'],
      json_data['on_spotify']
    )
    genre_data = json_data['genre']
    music_album.genre = genre_data.nil? ? nil : Genre.new(genre_data['name'], genre_data['description'])
    music_album
  end

  def list_music
    puts '========================================================'
    return puts 'The music list is empty' unless File.exist?('./modules/music/music.json')

    json_data = JSON.parse(File.read('./modules/music/music.json'))
    json_data.each do |album_data|
      album = MusicAlbum.new(
        album_data['title'],
        Date.parse(album_data['publish_date']),
        album_data['artist'],
        album_data['total_tracks'],
        album_data['on_spotify']
      )
      album.genre = Genre.new(album_data['genre']['name'], album_data['genre']['description']) if album_data['genre']

      puts 'All Music Albums:'
      puts "Title: #{album.title}, Published Date: #{album.publish_date}"
      puts "Artist: #{album.artist}, On Spotify: #{album.on_spotify}"
      puts "Genre: #{album.genre ? album.genre.name : 'N/A'}"
      puts '-' * 30
    end
  end

  def add_new_music_album
    puts 'Enter the Title of the Music Album:'
    title = gets.chomp

    puts 'Enter the Published Date of the Music Album (YYYY-MM-DD):'
    published_date_str = gets.chomp
    publish_date = Date.parse(published_date_str)

    puts 'Enter the Artist of the Music Album:'
    artist = gets.chomp

    puts 'Enter the Total Tracks of the Music Album:'
    total_tracks = gets.chomp.to_i

    puts 'Is the Music Album on Spotify? (true/false):'
    on_spotify = gets.chomp.downcase == 'true'
    puts 'Success adding music album'
    MusicAlbum.new(title, publish_date, artist, total_tracks, on_spotify)
  end
end
