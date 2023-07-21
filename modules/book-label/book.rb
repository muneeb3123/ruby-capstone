require_relative '../item'

class Book < Item
  attr_accessor :publisher, :cover_state, :genre, :id

  def initialize(publish_date, publisher, cover_state, _author,
                 _label, _genre, id: rand(1..1000))
    super(publish_date)
    @id = id
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?
    super || (@cover_state.downcase == 'bad')
  end

  def to_hash
    {
      id: @id,
      author: { first_name: author.first_name,
                last_name: author.last_name },
      label: { title: label.title, color: label.color },
      genre: { name: genre.name, genre_description: genre.description },
      publish_date: @publish_date,
      publisher: @publisher,
      cover_state: @cover_state
    }
  end
end
