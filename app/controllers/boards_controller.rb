class BoardsController < ApplicationController
  before_action :set_board, only: %i[edit update destroy]
  
  def index
    @boards = Board.all.includes(:user).order(created_at: :desc)
  end

  def show
    @board = Board.find(params[:id])
    @comments = @board.comments.includes(:user).order(created_at: :desc)
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

  def edit
    #@board = Board.find(params[:id])
  end

  def update
    #@board = Board.find(params[:id])
    if @board.update(board_params)
      redirect_to(@board, success: t('.success', item: Board.model_name.human))
    else
      flash.now[:danger] = t('.fail', item: Board.model_name.human)
      render "edit"
    end
  end

  def destroy
    #@board = Board.find(params[:id])
    @board.destroy!
    redirect_to(boards_path,flash:{success: t('.success')})
  end

  def bookmarks
    @boards = current_user.bookmark_boards.includes(:user).order(created_at: :desc)
    #@boards = current_user.bookmarks.includes(:user).order(created_at: :desc)
  end

  private

  def board_params
    params.require(:board).permit(:title, :body, :board_image, :board_image_cache)
  end

  def set_board
    @board = current_user.boards.find(params[:id])
  end

end
