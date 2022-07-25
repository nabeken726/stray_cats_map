class Post < ApplicationRecord
  has_one_attached :image

  belongs_to :genre
  belongs_to :user

  has_many :comments,   dependent: :destroy
  has_many :cutes,      dependent: :destroy
  has_many :looks,      dependent: :destroy

  # バリデーション
  # タイトル20文字まで
  validates :title,        presence: true, length: { maximum: 20 }
  # 内容50文字まで
  validates :introduction, presence: true, length: { maximum: 50 }
  validates :genre,        presence: true
  validates :image,        presence: true
  validates :latitude,     presence: true
  validates :longitude,    presence: true

  # 絞り込みのためのスコープ 退会済を弾く
  scope :narrow_down, -> { where.not(user_id: User.where(is_deleted: true).ids) }
  
  # 部分一致のみ
  def self.looks(search, word)
    if search == "partial_match"
      @post = Post.where("title LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end
  
  def self.initialize_with_association(params, user_id, genre_id)
    post = new(params)
    post.user_id = user_id
    post.genre_id = genre_id
    post
    
    # new(params).tap do |pst|
    #   pst.user_id = user_id
    #   pst.genre_id = genre_id
    # end
  end

  # かわいい、みた機能
  def cuted_by?(user)
    cutes.exists?(user_id: user.id)
  end

  def looked_by?(user)
    looks.exists?(user_id: user.id)
  end
end
