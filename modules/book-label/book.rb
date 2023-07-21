require_relative '../item'

class Book < Item
  attr_accessor :publisher, :cover_state, :genre, :id

  def initialize(publish_date, publisher, cover_state, id: rand(1..1000))
    super(publish_date)
    @id = id
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?
    super || (@cover_state.downcase == 'bad')
  end
end
