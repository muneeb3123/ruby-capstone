require_relative '../modules/music/music'
require_relative '../modules/item'

RSpec.describe MusicAlbum do
  describe '#can_be_archived?' do
    it 'should return false when on_spotify is false' do
      music_album = MusicAlbum.new('Joro-Wizzy', '2016-06-12', 'Wizkid', 3, false)
      expect(music_album.can_be_archived?).to be(false)
    end

    it 'should return true when on_spotify is true and published_date is older than 10 years' do
      music_album = MusicAlbum.new('Glory', '2000-01-01', 'Eminem', 6, true)
      expect(music_album.can_be_archived?).to be(true)
    end

    it 'should return false when on_spotify is true but published_date is not older than 10 years' do
      music_album = MusicAlbum.new('King Sark', '2023-07-20', 'Sarkodie', 5, true)
      expect(music_album.can_be_archived?).to be(false)
    end
  end
end
