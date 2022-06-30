module FileUtils
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
  rescue StandardError => e
    puts "Error loading #{type} from file: #{e.message}"
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
      save_instances_to_store([game.label, game.author, game.genre, game.source])
      @store.games << game
    when 'music_albums'
      params = music_album_params(raw_params)
      music = MusicAlbum.new(params)
      save_instances_to_store([music.label, music.author, music.genre, music.source])
      @store.music_albums << music
    else
      puts 'Unknown item type'
    end
  end
end
