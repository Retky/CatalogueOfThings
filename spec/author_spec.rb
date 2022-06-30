require_relative '../author'

describe Author do
  before(:each) do
    @author = Author.new(first_name: 'John', last_name: 'Smith')
  end

  context 'when initialized' do
    it 'should return a new instance of Author' do
      expect(@author).to be_a(Author)
    end

    it 'should take 1 parameter' do
      expect { Author.new }.to raise_error(ArgumentError)
    end
  end

  context '#first_name' do
    it 'should return a string' do
      expect(@author.first_name).to be_a(String)
    end
  end

  context '#last_name' do
    it 'should return a string' do
      expect(@author.last_name).to be_a(String)
    end
  end
end
