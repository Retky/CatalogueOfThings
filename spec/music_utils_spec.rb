require_relative '../app'

describe App do
  before(:each) do
    @app = App.new
  end

  context '#initialize' do
    it 'should return a new instance of App' do
      expect(@app).to be_a(App)
    end
  end

  context '#add_albums' do
    it 'should add an album to the albums array' do
      album = MusicAlbum.new(publish_date: Date.new(2018, 1, 1),
                             author: Author.new(first_name: 'John', last_name: 'Smith'),
                             label: Label.new(title: 'Warner Bros.'),
                             source: 'spotify',
                             genre: Genre.new(name: 'Rock'))
      @app.add_albums(album)
      expect(@app.albums).to include(album)
    end
  end

  context '#add_genre' do
    it 'should add a genre to the genres array' do
      genre = Genre.new(name: 'Rock')
      @app.add_genre(genre)
      expect(@app.genres).to include(genre)
    end
  end

  context '#list_music_albums' do
    it 'should return a string' do
      expect(@app.list_music_albums).to be_a(String)
    end
  end

  context '#list_genres' do
    it 'should return a string' do
      expect(@app.list_genres).to be_a(String)
    end
  end
end
