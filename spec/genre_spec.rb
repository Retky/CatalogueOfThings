require_relative '../genre'

describe Genre do
  context 'when initialized' do
    before(:each) do
      @genre = Genre.new(name: 'Rock')
    end

    it 'should return a new instance of Genre' do
      expect(@genre).to be_a(Genre)
    end

    it 'should have to take 1 parameter' do
      expect { Genre.new }.to raise_error(ArgumentError)
    end
  end

  context '#name' do
    it 'should return a string' do
      name = 'Rock'
      genre = Genre.new(name: name)
      expect(genre.name).to be_a(String)
    end
  end

  context '#items' do
    it 'should return an array' do
      genre = Genre.new(name: 'Rock')
      expect(genre.items).to be_a(Array)
    end
  end

  context '#id' do
    it 'should return a string' do
      id = SecureRandom.uuid.gsub('-', '').hex
      genre = Genre.new(id: id)
      expect(genre.id).to be_a(Integer)
    end
  end

  context '#add_item' do
    it 'should add an item to the items array' do
      genre = Genre.new(name: 'Rock')
      item = Item.new(title: 'The Wall')
      genre.add_item(item)
      expect(genre.items).to include(item)
    end
  end
end
