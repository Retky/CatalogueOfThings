require './item'
require 'date'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(publisher:, cover_state:, publish_date:, author:, **options)
    @publisher = publisher
    @cover_state = cover_state
    super(publish_date: publish_date, author: author, label: options[:label],
          source: options[:source], genre: options[:genre])
  end

  private

  def can_be_archived?
    super or @cover_state == 'bad'
  end
end
