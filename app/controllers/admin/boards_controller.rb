class Admin::BoardsController < Admin::BaseController
  before_action :set_board, only: %i[edit update show destroy]

  def index
    @q = Board.ransack(params[:q])
    @boards = @q.result(distinct: true).includes(:user).order(created_at: :desc).page(params[:page])
  end

  def show; end

  def edit; end

  def update
    if @board.update(board_params)
      redirect_to(admin_board_path(@board), success: t('.success', item: Board.model_name.human))
    else
      flash.now[:danger] = t('.fail', item: Board.model_name.human)
      render "edit"
    end
  end

  def destroy
    @board.destroy!
    redirect_to(admin_boards_path,flash:{success: t('.success')}, item: Board.model_name.human)
  end

  private

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end

  def set_board
    @board = Board.find(params[:id])
  end

end
