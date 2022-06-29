module MusicUtils
  def add_music_album(params = {})
    album = MusicAlbum.new(params)
    album.on_spotify?
    persist_params = {
      publish_date: params[:publish_date],
      author_first_name: params[:author].first_name,
      author_last_name: params[:author].last_name,
      label_title: params[:label].title,
      label_color: params[:label].color,
      source_name: params[:source].name,
      genre_name: params[:genre].name,
      on_spotify: params[:on_spotify]
    }
    @store.authors << params[:author]
    @store.genres << params[:genre]
    # add_genere(params[:genre].name)

    persist_item(persist_params, 'music_album')
    @store.music_albums << album
  end

  def add_genere(name:)
    genre = Genre.new(name: name)
    @store.genres << genre
  end

  def list_music_albums
    puts "\nMusic Albums:\n\n"
    @store.music_albums.each_with_index do |album, index|
      puts "#{index + 1}) #{album.author.first_name} #{album.author.last_name}" \
           "\t#{album.label.title}\t#{album.genre.name}\t#{album.publish_date}"
    end
  end

  def list_genres
    puts ['', 'Genres:']
    @store.genres.each_with_index { |genre, index| puts "#{index + 1}) #{genre.name}" }
  end
end
