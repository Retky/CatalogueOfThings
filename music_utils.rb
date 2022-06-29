module MusicUtils
  def add_albums(publish_date:, author:, label:, source:, genre:)
    album = MusicAlbum.new(publish_date: publish_date, author: author, label: label, source: source, genre: genre)
    album.on_spotify?
    @store.music_albums << album
  end

  def add_genere(name:)
    genre = Genre.new(name: name)
    @store.genres << genre
  end

  def list_music_albums
    puts ['', 'Music Albums:']
    @store.music_albums.each_with_index do |album, index|
      puts "#{index + 1}) #{album.author.first_name} #{album.author.last_name} \t\"" \
           "#{album.label.title}\" #{album.genre.name}, #{album.publish_date}"
    end
  end

  def list_genres
    puts ['', 'Genres:']
    @store.genres.each_with_index { |genre, index| puts "#{index + 1}) #{genre.name}" }
  end
end
