class BoardsController < ApplicationController
  def index
    @boards = Board.all.includes(:user).order(created_at: :desc)
  end

  def new
    @board = Board.new
  end

  def create
    #@board = Board.new(board_params)
    @board = current_user.boards.build(board_params)
    if @board.save
      #[, item: Board.model_name.human]を追加
      redirect_to(boards_path, flash:{success: t('.success', item: Board.model_name.human)})
    else
      flash.now[:danger] = t('.fail', item: Board.model_name.human)
      render "new"
    end
  end

  private

  def board_params
    params.require(:board).permit(:title, :body)
  end
end
