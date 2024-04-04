class BoardsController < ApplicationController
  protect_from_forgery except: :sort
  before_action :set_board, except: [:index, :new, :create, :sort]
  # respond_to :turbo_stream, only: [:create]

  def index
    @boards = Board.order(position: :asc)
    respond_with(@boards)
  end

  def show
  end

  def new
    @board = Board.new
    respond_with(@board)
  end

  def edit
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      respond_to :turbo_stream
    else
      respond_with(@board)
    end
  end

  def update
    @board.update(board_params)
    redirect_to boards_path
  end

  def destroy
    @board.destroy
    redirect_to boards_path
  end

  def sort
    if params[:item].present?
      @board = Board.find_by(id: params.dig(:item, :send))
      @board.insert_at(params.dig(:item, :position)&.to_i) if @board
    end
  end

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:title, :type, :position)
  end
end
