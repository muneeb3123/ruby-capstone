require 'date'

class Item
  attr_accessor :publish_date

  def initialize(publish_date)
    @id = rand(1..100)
    @publish_date = Date.parse(publish_date)
    @archived = false
  end

  def move_to_archived
    @archived = can_be_archived?
  end

  private

  def can_be_archived?
    (Date.today - @publish_date).to_i > (10 * 365)
  end
end