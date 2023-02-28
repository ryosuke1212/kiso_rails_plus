class BookmarksController < ApplicationController
  before_action :set_board, only: %i[create destroy]

  def create
    board = Board.find(params[:board_id])
    current_user.bookmark(board)
    #bookmark = @board.bookmarks.build(user_id: current_user.id)
    #redirect_to boards_path, success: t('.success')
  end

  def destroy
    board = current_user.bookmarks.find_by(board_id: params[:board_id]).board
    current_user.unbookmark(board)
    #board = Board.find(params[:board_id])
    #bookmark = @board.bookmarks.find_by(user_id: current_user.id)
    #redirect_back fallback_location: root_path, success: t('.success')
  end

  private

  def set_board
    @board = Board.find(params[:board_id])
  end

end
