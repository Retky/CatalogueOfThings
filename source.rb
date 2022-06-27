require 'securerandom'

class Source
  attr_accessor :name
  attr_reader :items, :id

  def initialize(name:)
    @name = name
    @id = SecureRandom.uuid.gsub('-', '').hex
    @items = []
  end

  def add_item(item)
    @items << item
  end
end
