module GameUtils
  def add_new_game
    inputs = inputs_for_new_item
    print 'multiplayer? (y/n): '
    multiplayer = gets[0].downcase == 'y'
    print 'last played (yyyy-mm-dd): '
    last_played = gets.chomp
    add_game({ author: Author.new(first_name: inputs[:author_first_name], last_name: inputs[:author_last_name]),
               label: Label.new(title: inputs[:label_title], color: inputs[:label_color]),
               genre: Genre.new(name: inputs[:genre_name]), source: Source.new(name: inputs[:source_name]),
               multiplayer: multiplayer, last_played: last_played })
    puts 'Game added!', ''
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
           "#{game.genre.name}, from: #{game.source.name}, #{game.publish_date} "
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
end
