require_relative 'item'

class MusicAlbum < Item
  attr_accessor :artist, :total_tracks, :on_spotify

  def initialize(_title, published_date, artist, total_tracks, on_spotify)
    super(published_date)
    @artist = artist
    @total_tracks = total_tracks
    @on_spotify = on_spotify
  end

  def can_be_archived?
    super && @on_spotify
  end

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
end
