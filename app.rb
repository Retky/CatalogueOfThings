require 'json'
require './author'
require './book'
require './genre'
require './label'
require './source'
require './store'
require './music_album'
require './music_utils'
require './game'

class App
  attr_accessor :store

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
    when 'book'
      params = book_params(raw_params)
      book = Book.new(params)
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
      genre: Genre.new(name: raw_params['genre_name']) }
  end

  def music_album_params(raw_params)
    { publish_date: raw_params['publish_date'],
      author: Author.new(first_name: raw_params['author_first_name'],
                         last_name: raw_params['author_last_name']),
      label: Label.new(title: raw_params['label_title'],
                       color: raw_params['label_color']),
      source: Source.new(name: raw_params['source_name']),
      genre: Genre.new(name: raw_params['genre_name']),
      on_spotify: raw_params['on_spotify'] }
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

music_album = MusicAlbum.new({ publish_date: '2018-01-01', author: Author.new(first_name: 'John', last_name: 'Doe'), label: Label.new(title: 'Game', color: 'red'), source: Source.new(name: 'Steam'), genre: Genre.new(name: 'Action'), on_spotify: true })

app = App.new
# app.add_music_album({ publish_date: '2018-01-01', author: Author.new(first_name: 'John', last_name: 'Doe'), label: Label.new(title: 'Game', color: 'red'), source: Source.new(name: 'Steam'), genre: Genre.new(name: 'Action'), on_spotify: true })

app.load_items('music_album')
p app.store.music_albums