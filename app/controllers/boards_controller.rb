class BoardsController < ApplicationController
  before_action :set_board, except: [:index, :new, :create]
  # respond_to :turbo_stream, only: [:create]

  def index
    @boards = Board.all
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

  private

  def set_board
    @board = Board.find(params[:id])
  end

  def board_params
    params.require(:board).permit(:title, :type, :position)
  end
end
