require 'securerandom'
require 'date'

class Item
  attr_accessor :publish_date
  attr_reader :id, :archived, :author, :label, :source, :genre

  def initialize(params)
    @id = SecureRandom.uuid.gsub('-', '').hex
    @publish_date = params[:publish_date]
    @author = params[:author]
    @label = params[:label]
    @source = params[:source]
    @genre = params[:genre]
    @archived = false
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  def genre=(genre)
    @genre = genre
    genre.items.push(self) unless genre.items.include?(self)
  end

  def source=(source)
    @source = source
    source.items.push(self) unless source.items.include?(self)
  end

  def label=(label)
    @label = label
    label.items.push(self) unless label.items.include?(self)
  end

  def author=(author)
    @author = author
    author.items.push(self) unless author.items.include?(self)
  end

  private

  def can_be_archived?
    (Date.today.year - @publish_date.year) > 10
  end
end
