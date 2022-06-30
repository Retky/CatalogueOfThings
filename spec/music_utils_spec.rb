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

  context '#add_music_album' do
    it 'should add an album to the albums array' do
      add_music_album = @app.add_music_album(publish_date: Date.new(2018, 1, 1),
                                             author: Author.new(first_name: 'John', last_name: 'Smith'),
                                             label: Label.new(title: 'Warner Bros.', color: 'red'),
                                             source: Source.new(name: 'spotify'),
                                             genre: Genre.new(name: 'Rock'), on_spotify: true)

      expect(@app.store.music_albums).to include(add_music_album[0])
    end
  end
end
