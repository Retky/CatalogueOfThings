module BookUtils
  def add_book(params = {})
    book = Book.new(params)
    persist_params = {
      publisher: params[:publisher],
      cover_state: params[:cover_state],
      publish_date: params[:publish_date],
      author_first_name: params[:author].first_name,
      author_last_name: params[:author].last_name,
      label_title: params[:label].title,
      label_color: params[:label].color,
      source_name: params[:source].name,
      genre_name: params[:genre].name
    }
    persist_item(persist_params, 'books')
    @store.books << book
  end

  def add_new_book
    inputs = inputs_for_new_item
    print 'publisher: '
    publisher = gets.chomp
    print 'Cover State (Good/Bad): '
    cover_state = gets.chomp
    add_book({ publisher: publisher, cover_state: cover_state, publish_date: inputs[:publish_date],
               author: Author.new(first_name: inputs[:author_first_name], last_name: inputs[:author_last_name]),
               label: Label.new(title: inputs[:label_title], color: inputs[:label_color]),
               genre: Genre.new(name: inputs[:genre_name]), source: Source.new(name: inputs[:source_name]) })
    puts 'Book added!', ''
  end

  def list_books
    book = Struct.new(:No, :title, :author, :genere, :source, :publisher, :cover_state, :publish_date)
    books = []
    7.times { print '=' }
    puts "\nBooks:"
    7.times { print '=' }
    puts "\n\n"
    store.books.each.with_index(1) do |b, i|
      books << book.new(i, b.label.title,
                        "#{b.author.first_name} #{b.author.last_name}",
                        b.genre.name, b.source.name, b.publisher, b.cover_state, b.publish_date)
    end
    tp books
  end

  def book_params(raw_params)
    { publisher: raw_params['publisher'], cover_state: raw_params['cover_state'],
      publish_date: raw_params['publish_date'],
      author: Author.new(first_name: raw_params['author_first_name'],
                         last_name: raw_params['author_last_name']),
      label: Label.new(title: raw_params['label_title'],
                       color: raw_params['label_color']),
      source: Source.new(name: raw_params['source_name']),
      genre: Genre.new(name: raw_params['genre_name']),
      on_spotify: raw_params['on_spotify'] }
  end
end
