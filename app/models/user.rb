class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :user_image_url

  # User画像のないときの処理
  def get_image
    unless user_image_url.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      user_image_url.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    user_image_url
  end

end
