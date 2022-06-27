class App
  def menus
    @menu_items = [
      '1. List all books',
      '2. List all music albums',
      '3. List all movies',
      '4. List of games',
      '5. List all geners',
      '6. List all labels',
      '7. List all authors',
      '8. List all sources',
      '9. Add a book',
      '10. Add a music album',
      '11. Add a movie',
      '12. Add a game',
      '13. Quit'
    ]
  end

  def run
    puts 'Welcome to the library!'
    45.times { print '-' }
    puts
    puts menus
    print "\nPlease select an option:"
  end
end

app = App.new
puts app.run
