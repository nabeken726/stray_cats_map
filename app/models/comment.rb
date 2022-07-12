class Comment < ApplicationRecord

  belongs_to :post
  belongs_to :user

  # コメント50文字まで
  validates :comment,presence:true, length: {maximum: 50}

end
