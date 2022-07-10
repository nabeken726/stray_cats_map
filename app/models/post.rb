class Post < ApplicationRecord


  has_one_attached :image
  # 画像が投稿されていない場合の記述

  belongs_to :genre
  belongs_to :user

  has_many :user_posts, dependent: :destroy
  has_many :comments,   dependent: :destroy
  has_many :cutes,   dependent: :destroy
  has_many :looks,   dependent: :destroy

  # バリデーション空欄処理だけ
  validates :title,presence:true
  validates :introduction,presence:true
  validates :genre,presence:true
  validates :image,presence:true
  validates :latitude,presence:true
  validates :longitude,presence:true

  # 名前はfavoritedにしてメソッドを作る
  # def cuted_by?(user)
  #   cutes.where.not(cute: nil).exists?(user_id: user.id)
  # end
   def cuted_by?(user)
    cutes.exists?(user_id: user.id)
   end
   def looked_by?(user)
    looks.exists?(user_id: user.id)
   end

end
