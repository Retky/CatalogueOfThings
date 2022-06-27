require 'securerandom'

class Author
  attr_accessor :first_name, :last_name
  attr_reader :items, :id

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
