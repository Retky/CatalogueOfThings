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

    persist_item(persist_params, 'music_albums')
    @store.music_albums << album
  end

  def add_new_music_album
    inputs = inputs_for_new_item
    print 'On spotify? (y/n): '
    on_spotify = gets.chomp.downcase == 'y'
    add_music_album({ publish_date: inputs[:publish_date],
                      author: Author.new(first_name: inputs[:author_first_name],
                                         last_name: inputs[:author_last_name]),
                      label: Label.new(title: inputs[:label_title], color: inputs[:label_color]),
                      genre: Genre.new(name: inputs[:genre_name]),
                      source: Source.new(name: inputs[:source_name]),
                      on_spotify: on_spotify })

    puts 'New album added!'
  end

  def list_music_albums
    puts "\nMusic Albums:\n\n"
    @store.music_albums.each_with_index do |album, index|
      puts "#{index + 1}) #{album.author.first_name} #{album.author.last_name}" \
           "\t#{album.label.title}\t#{album.genre.name}\t#{album.source.name}\t#{album.publish_date}"
    end
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
end
