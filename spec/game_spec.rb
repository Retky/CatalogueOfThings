require 'date'
require_relative '../game'
require_relative '../genre'
require_relative '../author'
require_relative '../label'

describe Game do
  before(:each) do
    params = {
      multiplayer: true,
      last_played_at: Date.new(2018, 1, 1),
      genre: Genre.new(name: 'Action'),
      author: Author.new(first_name: 'John', last_name: 'Smith'),
      label: Label.new(title: 'Epic Games', color: 'red'),
      source: 'steam',
      publish_date: Date.new(2000, 1, 1)
    }
    @game = Game.new(params)
  end

  context 'when initialized' do
    it 'should return a new instance of Game' do
      expect(@game).to be_a(Game)
    end

    it 'should have to take 1 parameter' do
      expect { Game.new }.to raise_error(ArgumentError)
    end
  end

  context '#publish_date' do
    it 'should return a Date object' do
      expect(@game.publish_date).to be_a(Date)
    end
  end

  context '#author' do
    it 'should return a Author object' do
      expect(@game.author).to be_a(Author)
    end
  end

  context '#label' do
    it 'should return a Label object' do
      expect(@game.label).to be_a(Label)
    end
  end

  context '#source' do
    it 'should return a string' do
      expect(@game.source).to be_a(String)
    end
  end

  context '#genre' do
    it 'should return a Genre object' do
      expect(@game.genre).to be_a(Genre)
    end
  end

  context '#can_be_archived?' do
    it 'should return false if super returns true and game is younger than 2 years' do
      @game.last_played_at = Date.today(-365)
      expect(@game.send(:can_be_archived?)).to be(false)
    end
  end

  context '#can_be_archived?' do
    it 'should return true if super returns true and last played is older than 2 years' do
      @game.last_played_at = Date.new(2018, 1, 1)
      expect(@game.send(:can_be_archived?)).to be(true)
    end
  end
end
