require './book'
require './author'
require './genre'
require './source'
require './label'

describe Book do
  before(:each) do
    @author = Author.new(first_name: 'John', last_name: 'Doe')
    @genre = Genre.new(name: 'Fantasy')
    @source = Source.new(name: 'Amazon')
    @label = Label.new(title: 'Random House', color: 'Red')
    @book = Book.new(params = { publisher: 'Random House', cover_state: 'good', publish_date: Date.new(2017, 1, 1), author: @author, label: @label, source: @source, genre: @genre })
  end

  it 'should have an author' do
    expect(@book.author.first_name).to eq('John')
    expect(@book.author.last_name).to eq('Doe')
  end

  it 'should have a genre' do
    expect(@book.genre.name).to eq('Fantasy')
  end

  it 'should have a source' do
    expect(@book.source.name).to eq('Amazon')
  end

  it 'should have a label' do
    expect(@book.label.title).to eq('Random House')
    expect(@book.label.color).to eq('Red')
  end

  it 'should have a publish date' do
    expect(@book.publish_date).to eq(Date.new(2017, 1, 1))
  end

  it 'should be able to be archived' do
    expect(@book.send(:can_be_archived?)).to eq(false)
  end

  it 'should be able to be archived if the cover is bad' do
    @book.cover_state = 'bad'
    expect(@book.send(:can_be_archived?)).to eq(true)
  end

  it 'should be able to be archived if the book has more than 10 years' do
    @book.publish_date = Date.new(2002, 1, 1)
    expect(@book.send(:can_be_archived?)).to eq(true)
  end
end
