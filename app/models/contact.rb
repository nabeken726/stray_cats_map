class Contact < ApplicationRecord

  validates :name, presence: true, length: { maximum: 15 }
  validates :content, presence: true, length: { maximum: 250 }

end
