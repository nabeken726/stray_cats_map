class Post < ApplicationRecord

  has_one_attached :image
  # 画像が投稿されていない場合の記述

  belongs_to :genre
  belongs_to :user

  has_many :user_posts, dependent: :destroy
  has_many :comments,   dependent: :destroy
  
  # バリデーション空欄処理だけ
  validates :title,presence:true
  validates :introduction,presence:true
  validates :genre,presence:true
  validates :image,presence:true

  # 名前はfavoritedにしてメソッドを作る
  def favorited_by?(user)
    comments.where.not(cute: nil).exists?(user_id: user.id)
  end
end
