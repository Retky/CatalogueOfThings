require_relative 'item'

class MusicAlbum < Item
  def initialize(publish_date:, author:, label:, source:, genre:)
    super(publish_date: publish_date, author: author, label: label, source: source, genre: genre)
  end

  def on_spotify?
    @source == 'spotify'
  end

  private

  def can_be_archived?
    super && on_spotify?
  end
end
