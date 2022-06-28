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
      add_albums = @app.add_albums(publish_date: Date.new(2018, 1, 1),
                                   author: Author.new(first_name: 'John', last_name: 'Smith'),
                                   label: Label.new(title: 'Warner Bros.', color: 'red'),
                                   source: 'spotify', genre: Genre.new(name: 'Rock'))

      expect(@app.store.music_albums).to include(add_albums[0])
    end
  end

  context '#add_genere' do
    it 'should add a genre to the genres array' do
      add_genere = @app.add_genere(name: 'Rock')
      expect(@app.store.genres).to include(add_genere[0])
    end
  end

  context '#list_music_albums' do
    it 'should return a string' do
      expect(@app.list_music_albums).to be_a(Array)
    end
  end

  context '#list_genres' do
    it 'should return a string' do
      expect(@app.list_genres).to be_a(Array)
    end
  end
end
