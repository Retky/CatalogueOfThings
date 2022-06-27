require 'securerandom'

class Source
  def initialize(name:)
    @name = name
    @id = SecureRandom.uuid.gsub('-', '').hex
    @items = []
  end

  def add_item(item)
    @items << item
  end
end
