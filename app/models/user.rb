class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image

  has_many :comments,   dependent: :destroy
  has_many :cutes,      dependent: :destroy
  has_many :looks,      dependent: :destroy
  
  # フォロー関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 一覧画面
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  
  # 名前のバリデーション※15文字まで 他のニックネームと被らないように
  validates :name, presence: true, length: { minimum: 2,maximum: 15 }, uniqueness: true
  
  # 絞り込みのためのスコープ 退会済を弾く
  scope :narrow_down, -> { where.not(user_id: User.where(is_deleted: true).ids) }

  # 退会したユーザーがログインできないように
  def active_for_authentication?
    super && (is_deleted == false)
  end
  
  # ゲストユーザー
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  # フォローしたときの処理
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # フォローを外すときの処理
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォローしているか判定
  def following?(user)
    followings.include?(user)
  end

  # User画像のないときの処理
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg')
    end
    image
  end
end
