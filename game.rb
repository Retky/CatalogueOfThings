require 'date'
require_relative 'item'

class Game < Item
  attr_accessor :multiplayer, :last_played_at

  def initialize(params)
    super(publish_date: params[:publish_date], author: params[:author], label: params[:label],
          source: params[:source], genre: params[:genre])

    @multiplayer = params[:multiplayer]
    @last_played_at = Date.new(params[:last_played_at].to_i)
  end

  private

  def can_be_archived?
    super and (Date.today.year - @last_played_at.year > 2)
  end
end
