class Post < ApplicationRecord
  has_one_attached :image
  # 画像が投稿されていない場合の記述

  belongs_to :genre
  belongs_to :user

  has_many :user_posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :cutes, dependent: :destroy
  has_many :looks, dependent: :destroy

  # バリデーション
  # タイトル20文字まで
  validates :title, presence: true, length: { maximum: 20 }
  # 内容50文字まで
  validates :introduction, presence: true, length: { maximum: 50 }
  validates :genre,       presence: true
  validates :image,       presence: true
  validates :latitude,    presence: true
  validates :longitude,   presence: true

  # かわいい、みた機能
  def cuted_by?(user)
    cutes.exists?(user_id: user.id)
  end

  def looked_by?(user)
    looks.exists?(user_id: user.id)
  end
end
