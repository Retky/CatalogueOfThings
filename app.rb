require './author'
require './book'
require './genre'
require './label'
require './source'
require './store'
require './music_utils'
require './game'

class App
  attr_reader :store

  include MusicUtils

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

  def add_book(publisher:, cover_state:, publish_date:, author:, **options)
    book = Book.new(publisher: publisher, cover_state: cover_state, publish_date: publish_date, author: author,
                    label: options[:label], source: options[:source], genre: options[:genre])
    @store.books << book
  end

  def add_label(title:, color:)
    label = Label.new(title: title, color: color)
    @store.labels << label
  end

  def add_game(params = {})
    game = Game.new(params)
    @store.games << game
  end

  def list_games
    puts ['', 'Games:']
    store.games.each_with_index do |game, index|
      puts "#{index + 1}) #{game.label.title} \"#{game.author.first_name} #{game.author.last_name}\"," \
           "#{game.publisher}, #{game.genre.name}, from: #{game.source.name}, #{game.publish_date} "
    end
  end

  def list_authors
    puts ['', 'Authors:']
    store.authors.each do |author|
      puts "#{author.first_name} #{author.last_name}"
    end
  end

  def run
    main_menu
  end
end
