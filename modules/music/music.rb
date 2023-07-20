require_relative '../item'

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
end
