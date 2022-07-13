class Genre < ApplicationRecord
  has_many :posts, dependent: :destroy
  # genreのバリデーション※15文字まで
  validates :genre, presence: true,length: { maximum: 15 }
end
