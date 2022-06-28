require_relative '../music_album'

describe MusicAlbum do
  context 'when initialized' do
    before(:each) do
      @publish_date = Date.new(2018, 1, 1)
      @author = Author.new(first_name: 'John', last_name: 'Smith')
      @label = Label.new(title: 'Warner Bros.')
      @source = 'spotify'
      @genre = Genre.new(name: 'Rock')
      @album = MusicAlbum.new(publish_date: @publish_date, author: @author, label: @label,
                              source: @source, genre: @genre)
    end

    it 'should return a new instance of MusicAlbum' do
      expect(@album).to be_a(MusicAlbum)
    end

    it 'should have to take 5 parameters' do
      expect { MusicAlbum.new }.to raise_error(ArgumentError)
    end
  end

  context '#publish_date' do
    it 'should return a Date object' do
      publish_date = Date.new(2018, 1, 1)
      album = MusicAlbum.new(publish_date: publish_date)
      expect(album.publish_date).to be_a(Date)
    end
  end

  context '#author' do
    it 'should return a Author object' do
      author = Author.new(first_name: 'John', last_name: 'Smith')
      album = MusicAlbum.new(author: author)
      expect(album.author).to be_a(Author)
    end
  end

  context '#label' do
    it 'should return a Label object' do
      label = Label.new(title: 'Warner Bros.')
      album = MusicAlbum.new(label: label)
      expect(album.label).to be_a(Label)
    end
  end

  context '#source' do
    it 'should return a string' do
      source = 'spotify'
      album = MusicAlbum.new(source: source)
      expect(album.source).to be_a(String)
    end
  end

  context '#genre' do
    it 'should return a Genre object' do
      genre = Genre.new(name: 'Rock')
      album = MusicAlbum.new(genre: genre)
      expect(album.genre).to be_a(Genre)
    end
  end

  context '#can_be_archived?' do
    it 'should return true if the album is not on Spotify' do
      album = MusicAlbum.new(source: 'itunes')
      expect(album.can_be_archived?).to be(true)
    end

    it 'should return true if the album is on Spotify and the cover is good' do
      album = MusicAlbum.new(source: 'spotify', cover_state: 'good')
      expect(album.can_be_archived?).to be(true)
    end

    it 'should return false if the album is on Spotify and the cover is bad' do
      album = MusicAlbum.new(source: 'spotify', cover_state: 'bad')
      expect(album.can_be_archived?).to be(false)
    end
  end

  context '#on_spotify?' do
    it 'should return true if the album is on Spotify' do
      album = MusicAlbum.new(source: 'spotify')
      expect(album.on_spotify?).to be(true)
    end

    it 'should return false if the album is not on Spotify' do
      album = MusicAlbum.new(source: 'itunes')
      expect(album.on_spotify?).to be(false)
    end
  end
end
