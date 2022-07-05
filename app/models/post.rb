class Post < ApplicationRecord

  has_one_attached :post_image_url
  # 画像が投稿されていない場合の記述
  # ポストはいらないかも
  

end
