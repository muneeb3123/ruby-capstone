require_relative '../item'

class MusicAlbum < Item
  attr_accessor :title, :artist, :total_tracks, :on_spotify, :genre

  def initialize(title, publish_date, artist, total_tracks, on_spotify)
    super(publish_date)
    @title = title
    @artist = artist
    @total_tracks = total_tracks
    @on_spotify = on_spotify
    @genre = nil
  end

  def can_be_archived?
    super && @on_spotify
  end
end
