class AddUniqueToCute < ActiveRecord::Migration[6.1]
  def change
    add_index :cutes, [:user_id, :post_id], unique: true
  end
end
