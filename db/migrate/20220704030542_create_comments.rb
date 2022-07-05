class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :post_id
      t.text :comment,null: false
      t.integer :look
      t.integer :cute
      t.timestamps
    end
  end
end
