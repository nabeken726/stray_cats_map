class DropUserPosts < ActiveRecord::Migration[6.1]
  def change
       drop_table :user_posts do |t|
        t.integer :user_id
        t.integer :post_id
    end
  end
end
