require 'json'
require './author'
require './book'
require './genre'
require './label'
require './source'
require './store'
require './music_album'
require './utility/book_utils'
require './utility/music_utils'
require './utility/game_utils'
require './utility/file_utils'
require './game'

class App
  attr_accessor :store

  include BookUtils
  include MusicUtils
  include GameUtils
  include FileUtils

  def initialize
    @store = Store.new
    load_items('books')
    load_items('games')
    load_items('music_albums')
  end

  def main_menu
    @main_menu = [
      ' 1) List books', ' 2) List music albums', ' 3) List games',
      ' 4) List genres', ' 5) List labels', ' 6) List authors',
      ' 7) List sources', ' 8) Add book', ' 9) Add music album',
      '10) Add game', '11) Exit'
    ]
    puts '', 'Welcome to the catalogue of things!'
    puts 'What would you like to do? (Select a number)'
    puts @main_menu
    main_selection
  end

  def main_selection
    methods = { 1 => :list_books, 2 => :list_music_albums, 3 => :list_games, 4 => :list_genres, 5 => :list_labels,
                6 => :list_authors, 7 => :list_sources, 8 => :add_new_book,
                9 => :add_new_music_album, 10 => :add_new_game, 11 => :abort }
    selection = gets.chomp.to_i
    if methods[selection]
      send(methods[selection])
    else
      puts 'Invalid selection'
    end
    main_menu
  end

  def inputs_for_new_item
    print 'Title: '
    label_title = gets.chomp
    print 'Author First Name: '
    author_first_name = gets.chomp
    print 'Author Last Name: '
    author_last_name = gets.chomp
    print 'Genre: '
    genre_name = gets.chomp
    print 'Source: '
    source_name = gets.chomp
    print 'publish date (yyyy-mm-dd): '
    publish_date = gets.chomp
    { label_title: label_title, author_first_name: author_first_name,
      author_last_name: author_last_name, genre_name: genre_name, source_name: source_name,
      publish_date: publish_date, label_color: 'Bugs Bunny' }
  end

  def list_genres
    puts ['', 'Genres:']
    store.genres.each { |genre| puts genre.name }
  end

  def list_labels
    puts ['', 'Labels:']
    store.labels.each { |label| puts "#{label.title}, Color: #{label.color}" }
  end

  def list_sources
    puts ['', 'Sources:']
    @store.sources.each { |source| puts source.name }
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
