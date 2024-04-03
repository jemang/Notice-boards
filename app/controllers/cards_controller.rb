class CardsController < ApplicationController
  before_action :set_card, except: [:index, :new, :create]
  before_action :set_board

  def index
    @cards = Card.where(parent_id: @board.id)
    respond_with(@cards)
  end

  def show
  end

  def new
    @card = Card.new
    @card.parent_id = @board.id
    respond_with(@card)
  end

  def edit
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      respond_to :turbo_stream
    else
      respond_with(@card)
    end
  end

  def update
    @card.update(card_params)
    respond_with(@card)
  end

  def destroy
    @card.destroy
    redirect_to boards_path
  end

  private

  def set_card
    @card = Card.find(params[:id])
  end

  def set_board
    board_id = params[:board_id] || params.dig(:card, :parent_id) || @card&.parent_id
    @board = Board.find(board_id)
  end

  def card_params
    params.require(:card).permit(:title, :type, :position, :parent_id, :note)
  end
end
