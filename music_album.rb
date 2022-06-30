require_relative 'item'

class MusicAlbum < Item
  def initialize(params = {})
    super(publish_date: params[:publish_date], author: params[:author],
          label: params[:label], source: params[:source], genre: params[:genre])
    @on_spotify = params[:on_spotify]
  end

  def on_spotify?
    @on_spotify = false unless @source == 'spotify'
    @on_spotify
  end

  private

  def can_be_archived?
    super && @on_spotify
  end
end
