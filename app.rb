require './author'
require './book'
require './genre'
require './label'
require './source'
require './store'

class App
  attr_reader :store

  def initialize
    @store = Store.new
  end

  def add_book(publisher:, cover_state:, publish_date:, author:, label:, source:, genre:)
    book = Book.new(publisher: publisher, cover_state: cover_state, publish_date: publish_date, author: author, label: label, source: source, genre: genre)
    @store.books << book
  end

  def add_label(title:, color:)
    label = Label.new(title: title, color: color)
    @store.labels << label
  end
end
