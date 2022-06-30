require 'json'
require 'table_print'
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
    puts
    46.times { print '=' }
    puts "\n> What would you like to do? (Select a number)"
    46.times { print '-' }
    puts "\n\n"
    puts @main_menu
    print "\n[Menu] > "
    main_selection
  end

  def main_selection
    methods = { 1 => :list_books, 2 => :list_music_albums, 3 => :list_games, 4 => :list_genres, 5 => :list_labels,
                6 => :list_authors, 7 => :list_sources, 8 => :add_new_book,
                9 => :add_new_music_album, 10 => :add_new_game, 11 => :abort }
    selection = gets.chomp.to_i
    system('clear')
    if methods[selection]
      send(methods[selection])
      print "\n> [Press press any key to exit]: "
      gets.chomp
      system('clear')
    else
      puts 'Invalid selection, please select a number from the menu.'
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
    genre = Struct.new(:No, :name)
    genres = []
    7.times { print '=' }
    puts "\nGenres:"
    7.times { print '=' }
    puts "\n\n"
    genre_name = store.genres.map(&:name).uniq!
    genre_name.each.with_index(1) { |name, i| genres << genre.new(i, name) }
    tp genres
  end

  def list_labels
    label = Struct.new(:No, :name, :color)
    labels = []
    7.times { print '=' }
    puts "\nLabels:"
    7.times { print '=' }
    puts "\n\n"
    store.labels.each.with_index(1) { |l, i| labels << label.new(i, l.title, l.color) }
    tp labels
  end

  def list_sources
    source = Struct.new(:No, :name)
    sources = []
    7.times { print '=' }
    puts "\nSources:"
    7.times { print '=' }
    puts "\n\n"
    source_name = store.sources.map(&:name).uniq!
    source_name.each.with_index(1) { |name, i| sources << source.new(i, name) }
    tp sources
  end

  def list_authors
    author = Struct.new(:No, :first_name, :last_name)
    authors = []
    7.times { print '=' }
    puts "\nAuthors:"
    7.times { print '=' }
    puts "\n\n"
    store.authors.each.with_index(1) { |a, i| authors << author.new(i, a.first_name, a.last_name) }
    tp authors
  end

  def run
    puts "\n    Welcome to the catalogue of things!"
    main_menu
  end
end
