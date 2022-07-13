class AddUniqueToLook < ActiveRecord::Migration[6.1]
  def change
    add_index :looks, [:user_id, :post_id], unique: true
  end
end
