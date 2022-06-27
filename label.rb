require 'securerandom'

class Label
  def initialize(title:, color:)
    @title = title
    @color = color
    @id = SecureRandom.uuid.gsub('-', '').hex
    @items = []
  end

  def add_item(item)
    @items << item
  end
end
