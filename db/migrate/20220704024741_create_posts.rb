class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
    t.integer :user_id,  null: false
    t.string :title,       null: false
    t.text :introduction, null: false
    t.text :post_image_url, null: false
    t.timestamps
    end
  end
end
