class Genre < ApplicationRecord

  belongs_to :post
  #nameのバリデーション
  validates :genre, presence: true

end
