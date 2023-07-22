require 'date'
require_relative '../item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(publish_date, multiplayer, last_played_at, id: rand(1..1000))
    super(Date.parse(publish_date))
    @id = id
    @multiplayer = multiplayer
    @last_played_at = Date.parse(last_played_at)
  end

  def can_be_archived?
    super && (Date.today - @last_played_at).to_i > (2 * 365)
  end

  def to_hash
    {
      id: @id,
      publish_date: @publish_date,
      multiplayer: @multiplayer,
      last_played_at: @last_played_at
    }
  end
end
