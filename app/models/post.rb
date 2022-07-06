class Post < ApplicationRecord

  has_one_attached :image
  # 画像が投稿されていない場合の記述
  # ポストはいらないかも

  has_many :user_posts, dependent: :destroy
  has_many :genres, dependent: :destroy
  has_many :comments, dependent: :destroy

end
