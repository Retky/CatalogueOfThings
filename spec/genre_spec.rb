require_relative '../genre'
require './item'
require './author'
require './label'

describe Genre do
  before(:each) do
    @genre = Genre.new(name: 'Rock')
  end

  context 'when initialized' do
    it 'should return a new instance of Genre' do
      expect(@genre).to be_a(Genre)
    end

    it 'should have to take 1 parameter' do
      expect { Genre.new }.to raise_error(ArgumentError)
    end
  end

  context '#name' do
    it 'should return a string' do
      expect(@genre.name).to be_a(String)
    end
  end

  context '#add_item' do
    it 'should add an item to the items array' do
      item = Item.new(publish_date: Date.new(2018, 1, 1),
                      author: Author.new(first_name: 'John', last_name: 'Smith'),
                      label: Label.new(title: 'Warner Bros.', color: 'red'),
                      source: 'spotify', genre: @genre)
      @genre.add_item(item)
      expect(@genre.items).to include(item)
    end
  end
end
