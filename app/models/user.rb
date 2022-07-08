class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image


  has_many :user_posts, dependent: :destroy
  has_many :comments,   dependent: :destroy

  # 退会したユーザーがログインできないように
  def active_for_authentication?
    super && ( is_deleted == false )
  end


  # User画像のないときの処理
  # class: "rounded-circle", size: "150x150"のクラスを当てる方法
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg')
    end
    image
  end

end
