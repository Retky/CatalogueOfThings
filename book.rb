require './item'

class Book < Item
  attr_accessor :publisher, :cover_state

  def initialize(params)
    @publisher = params[:publisher]
    @cover_state = params[:cover_state]
    super(params)
  end

  private

  def can_be_archived?
    super or @cover_state == 'bad'
  end
end
