require './author'
require './book'
require './genre'
require './label'
require './source'
require './store'

class App
  attr_reader :store

  def initialize
    @store = Store.new
  end
end