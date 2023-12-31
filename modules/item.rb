require 'date'

class Item
  attr_accessor :publish_date, :author
  attr_reader :label

  def initialize(publish_date, id: rand(1..1000))
    @id = id
    @publish_date = publish_date
    @archived = false
  end

  def move_to_archived
    @archived = can_be_archived?
  end

  def add_label(label)
    @label = label
    label.add_item(self) unless label.items.include?(self)
  end

  def add_author(author)
    @author = author
    author.add_item(self) unless author.items.include?(self)
  end

  def add_genre(genre)
    @genre = genre
    genre.add_item(self) unless genre.items.include?(self)
  end

  private

  def can_be_archived?
    (Date.today - @publish_date).to_i > (10 * 365)
  end
end
