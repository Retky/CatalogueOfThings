require 'securerandom'
require 'date'

class Item
  attr_accessor :publish_date, :author, :label, :source, :genre
  attr_reader :id, :archived

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

  private

  def can_be_archived?
    # TODO: implement better check
    (Date.today.year - @publish_date.year) > 10
  end
end
