class User < ApplicationRecord
  authenticates_with_sorcery!
  mount_uploader :avatar, AvatarUploader

  has_many :boards, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_boards, through: :bookmarks, source: :board

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true
  validates :email, presence: true
  
  validates :first_name, presence: true
  validates :first_name, length: { maximum: 255 }
  validates :last_name, presence: true
  validates :last_name, length: { maximum: 255 }

  def own?(object)
    id == object.user_id
  end

  # 引数に渡されたboardがブックマークされているか？
  def bookmark?(object)
    bookmark_boards.include?(object)
  end

  # board_idを入れてブックマークしてください
  def bookmark(board)
    # current_userがブックマークしているboardの配列にboardを入れる
    bookmark_boards << board
  end

  # 引数のboardのidをもつ、レコードを削除してください
  def unbookmark(board)
    bookmark_boards.destroy(board)
  end

end
