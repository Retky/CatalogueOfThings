require 'securerandom'

class Author
  def initialize(first_name:, last_name:)
    @first_name = first_name
    @last_name = last_name
    @id = SecureRandom.uuid.gsub('-', '').hex
    @items = []
  end

  def add_item(item)
    @items << item
  end
end
