require 'date'

class Item
  attr_accessor :publish_date

  def initialize(publish_date, id: rand(1..1000))
    @id = id
    @publish_date = Date.parse(publish_date)
    @archived = false
  end

  def move_to_archived
    @archived = can_be_archived?
  end

  def add_label(label)
    @label = label
    label.add_item(self) unless label.items.include?(self)
  end

  def can_be_archived?
    Date.today.year - @publish_date.year > (10 * 365)
  end    
end