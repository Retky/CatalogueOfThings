require './item'

class Game
  def initialize(params = {})
    super(params[:publish_date], params[:author], params[:label], params[:source], params[:genre])
    @multiplayer = params[:multiplayer]
    @last_played_at = params[:last_played_at]
  end

  private

  def can_be_archived?
    super and (Date.today.year - @last_played_at.year > 2)
  end
end
