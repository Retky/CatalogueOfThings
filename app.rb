require 'pry'
require 'json'
require './author'
require './book'
require './genre'
require './label'
require './source'
require './store'
require './music_utils'
require './game'

class App
  attr_accessor :store

  include MusicUtils

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
                6 => :list_authors, 7 => :list_sources, 8 => :add_book,
                9 => :add_music_album, 10 => :add_game, 11 => :abort }
    selection = gets.chomp.to_i
    if methods[selection]
      send(methods[selection])
    else
      puts 'Invalid selection'
    end
    main_menu
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

  def list_genres
    puts ['', 'Genres:']
    store.genres.each { |genre| puts genre.name }
  end

  def list_sources
    puts ['', 'Sources:']
    store.sources.each { |source| puts source.name }
  end

  def add_book(params = {})
    book = Book.new(params)
    persist_params = {
      publisher: params[:publisher],
      cover_state: params[:cover_state],
      publish_date: params[:publish_date],
      author_first_name: params[:author].first_name,
      author_last_name: params[:author].last_name,
      label_title: params[:label].title,
      label_color: params[:label].color,
      source_name: params[:source].name,
      genre_name: params[:genre].name
    }
    persist_item(persist_params, 'books')
    @store.books << book
  end

  def add_label(title:, color:)
    label = Label.new(title: title, color: color)
    @store.labels << label
  end

  def add_game(params = {})
    game = Game.new(params)
    persist_params = {
      publish_date: params[:publish_date],
      author_first_name: params[:author].first_name,
      author_last_name: params[:author].last_name,
      label_title: params[:label].title,
      label_color: params[:label].color,
      source_name: params[:source].name,
      genre_name: params[:genre].name,
      multiplayer: true, last_played_at: '2018-01-01'
    }
    persist_item(persist_params, 'games')
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

  def persist_item(params, type)
    File.open("#{type}.json", 'a') do |file|
      file.write("#{params.to_json}\n")
    end
  end

  def save_instances_to_store(objects)
    objects.each do |object|
      case object.class.to_s
      when 'Label'
        @store.labels << object
      when 'Author'
        @store.authors << object
      when 'Genre'
        @store.genres << object
      when 'Source'
        @store.sources << object
      end
    end
  end

  def load_items(type)
    File.open("#{type}.json", 'r') do |file|
      file.each_line do |line|
        params = JSON.parse(line)
        recreate_item(params, type)
      end
    end
  end

  def recreate_item(raw_params, type)
    case type
    when 'books'
      params = book_params(raw_params)
      book = Book.new(params)
      save_instances_to_store([book.label, book.author, book.genre, book.source])
      @store.books << book
    when 'games'
      params = game_params(raw_params)
      game = Game.new(params)
      @store.games << game
    when 'music_album'
      params = music_album_params(raw_params)
      music = MusicAlbum.new(params)
      @store.music_albums << music
    else
      puts 'Unknown item type'
    end
  end

  def game_params(raw_params)
    { publish_date: raw_params['publish_date'],
      author: Author.new(first_name: raw_params['author_first_name'],
                         last_name: raw_params['author_last_name']),
      label: Label.new(title: raw_params['label_title'],
                       color: raw_params['label_color']),
      source: Source.new(name: raw_params['source_name']),
      genre: Genre.new(name: raw_params['genre_name']),
      multiplayer: raw_params['multiplayer'],
      last_played_at: raw_params['last_played_at'] }
  end

  def book_params(raw_params)
    { publisher: raw_params['publisher'], cover_state: raw_params['cover_state'],
      publish_date: raw_params['publish_date'],
      author: Author.new(first_name: raw_params['author_first_name'],
                         last_name: raw_params['author_last_name']),
      label: Label.new(title: raw_params['label_title'],
                       color: raw_params['label_color']),
      source: Source.new(name: raw_params['source_name']),
      genre: Genre.new(name: raw_params['genre_name']),
      on_spotify: raw_params['on_spotify'] }
  end

  def music_album_params(raw_params)
    { publish_date: raw_params['publish_date'],
      author: Author.new(first_name: raw_params['author_first_name'],
                         last_name: raw_params['author_last_name']),
      label: Label.new(title: raw_params['label_title'],
                       color: raw_params['label_color']),
      source: Source.new(name: raw_params['source_name']),
      genre: Genre.new(name: raw_params['genre_name']) }
  end

  def run
    main_menu
  end
end

# game = Game.new({ publish_date: '2018-01-01', author: Author.new(first_name: 'John', last_name: 'Doe'),
#                   label: Label.new(title: 'Game', color: 'red'), source: Source.new(name: 'Steam'),
#                   genre: Genre.new(name: 'Action'), multiplayer: true, last_played_at: '2018-01-01' })

# app = App.new
# app.add_game({ publish_date: '2018-01-01', author: Author.new(first_name: 'John', last_name: 'Doe'),
#                label: Label.new(title: 'Game', color: 'red'), source: Source.new(name: 'Steam'),
#                genre: Genre.new(name: 'Action'), multiplayer: true, last_played_at: '2018-01-01' })
# app.load_items('games')
# p app.store.games

# require 'date'
app = App.new
# #add The lord of the rings
# app.add_book({ publish_date: Date.new(1954, 1, 1), publisher: 'Allen & Unwin', cover_state: 'good',
#                author: Author.new(first_name: 'J.R.R.', last_name: 'Tolkien'), label: Label.new(title: 'Lord of the Rings', color: 'yellow'), source: Source.new(name: 'Amazon'), genre: Genre.new(name: 'Fantasy') })
# # add Harry Potter and the Philosopher's Stone
# app.add_book({ publish_date: Date.new(1997, 1, 1), publisher: 'Bloomsbury', cover_state: 'good',
#                author: Author.new(first_name: 'J.K.', last_name: 'Rowling'), label: Label.new(title: 'Harry Potter and the Philosopher\'s Stone', color: 'blue'), source: Source.new(name: 'Amazon'), genre: Genre.new(name: 'Fantasy') })
# # add Robin Hood
# app.add_book({ publish_date: Date.new(1850, 1, 1), publisher: 'William Morrow', cover_state: 'good',
#                author: Author.new(first_name: 'Mark', last_name: 'Twain'), label: Label.new(title: 'Robin Hood', color: 'red'), source: Source.new(name: 'Amazon'), genre: Genre.new(name: 'Fantasy') })
app.load_items('books')
