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

  def main_menu
    puts 'Welcome to the catalogue of things!'
  end

  def list_books
    puts ['', 'Books:']
    store.books.each_with_index do |book, index|
      puts "#{index + 1}) #{book.label.title} \"#{book.author.first_name} #{book.author.last_name}\"," \
           "#{book.publisher}, #{book.genre.name}, from: #{book.source.name}, #{book.publish_date} "
    end
  end

  def list_labels
    puts ['', 'Labels:']
    store.labels.each { |label| puts "#{label.title}, Color: #{label.color}" }
  end

  def add_book(publisher:, cover_state:, publish_date:, **options)
    params = { publisher: publisher, cover_state: cover_state, publish_date: publish_date, author: options[:author],
               label: options[:label], source: options[:source], genre: options[:genre] }
    book = Book.new(params)
    @store.books << book
  end

  def add_label(title:, color:)
    label = Label.new(title: title, color: color)
    @store.labels << label
  end

  def run
    main_menu
  end
end
