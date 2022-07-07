class Post < ApplicationRecord

  has_one_attached :image
  # 画像が投稿されていない場合の記述
  # ポストはいらないかも

  belongs_to :genre
  belongs_to :user

  has_many :user_posts, dependent: :destroy
  has_many :comments,   dependent: :destroy

  # 名前はfavoritedにしてメソッドを作る
  def favorited_by?(user)
    comments.exists?(user_id: user.id)
  end
end
