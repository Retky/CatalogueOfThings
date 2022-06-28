require 'securerandom'

class Item
  attr_accessor :publish_date
  attr_reader :id, :archived, :author, :label, :source, :genre

  def initialize(publish_date:, author:, label:, source:, genre:)
    @id = SecureRandom.uuid.gsub('-', '').hex
    @publish_date = publish_date
    @author = author
    @label = label
    @source = source
    @genre = genre
    @archived = false
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  def genre=(genre)
    @genre = genre
    genre.items.push(self) unless genre.items.include?
  end

  private

  def can_be_archived?
    # TODO: implement better check
    (Date.today.year - @publish_date.year) > 10
  end
end
