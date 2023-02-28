class Board < ApplicationRecord
  #require 'carrierwave/orm/activerecord'
  mount_uploader :board_image, BoardImageUploader
  
  belongs_to :user
  has_many :comments, dependent: :destroy
  #下の一行を追加
  has_many :bookmarks, dependent: :destroy

  def bookmarked_by?(user)
    bookmarks.where(user_id: user).exists?
  end

  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
end
