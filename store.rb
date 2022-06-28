class Store
  attr_accessor :books, :music_albums, :movies, :games, :genres, :labels, :authors, :sources

  def initialize
    @books = []
    @music_albums = []
    @movies = []
    @games = []
    @genres = []
    @labels = []
    @authors = []
    @sources = []
  end
end
