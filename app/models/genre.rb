class Genre < ApplicationRecord

  has_many :posts, dependent: :destroy
  #genreのバリデーション
  validates :genre, presence: true

end
