class Genre < ApplicationRecord

  has_many :posts, dependent: :destroy
  #nameのバリデーション
  validates :genre, presence: true

end
