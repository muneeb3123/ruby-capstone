require 'date'
require_relative 'item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(publish_date, multiplayer, last_played_at, author, id: rand(1..1000))
    super(publish_date, author)
    @id = id
    @multiplayer = multiplayer
    @last_played_at = Date.parse(last_played_at)
    @author = author
  end

  def can_be_archived?
    super && (Date.today - @last_played_at).to_i > (2 * 365)
  end
end
