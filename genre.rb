require 'securerandom'

class Genre
  attr_accessor :name
  attr_reader :items, :id

  def initialize(name:)
    @name = name
    @id = SecureRandom.uuid.gsub('-', '').hex
    @items = []
  end

  def add_item(item)
    @items << item
    item.genre = self
  end
end
