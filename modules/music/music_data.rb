require 'json'

module MusicData
  def save_music(music_album)
    File.open(music_album, 'w') do |album|
      json_data = {
        title: @title,
        published_date: @published_date.to_s,
        artist: @artist,
        total_tracks: @total_tracks,
        on_spotify: @on_spotify,
        genre: @genre&.to_json
      }
      album.write(JSON.generate(json_data))
    end
  end

  def load_music(music_album)
    json_data = JSON.parse(File.read(music_album))
    music_album = MusicAlbum.new(
      json_data['title'],
      Date.parse(json_data['published_date']),
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
    return puts 'The music list is empty' unless File.exist?('./music.json')

    json_data = JSON.parse(File.read('music.json'))
    json_data.map do |album_data|
      albums = MusicAlbum.new(
        album_data['title'],
        Date.parse(album_data['published_date']),
        album_data['artist'],
        album_data['total_tracks'],
        album_data['on_spotify']
      )
      albums.genre = Genre.new(album_data['genre']['name'], album_data['genre']['description']) if album_data['genre']

      puts 'All Music Albums:'
      albums.each do |album|
        puts "Title: #{album.title}, Published Date: #{album.published_date}"
        puts "Artist: #{album.artist}, On Spotify: #{album.on_spotify}"
        puts "Genre: #{album.genre ? album.genre.name : 'N/A'}"
        puts '-' * 30
      end
    end
  end
end
