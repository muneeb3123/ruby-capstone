require_relative '../modules/game'

describe Game do
  game = Game.new('2010-01-01', true, '2021-01-01')

  describe '#can_be_archived?' do
    it 'should return true if parents method returns true AND if last_played_at is older than 2 years' do
      expect(game.can_be_archived?).to eq(true)
    end
    it 'should return false if parents method returns true AND if last_played_at is younger than 2 years' do
      game.last_played_at = Date.today - 365
      expect(game.can_be_archived?).to eq(false)
    end
    it 'should return false if parents method returns false AND if last_played_at is older than 2 years' do
      game.publish_date = Date.today - (11 * 365)
      expect(game.can_be_archived?).to eq(false)
    end
  end
end
