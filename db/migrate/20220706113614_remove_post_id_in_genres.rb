class RemovePostIdInGenres < ActiveRecord::Migration[6.1]
  def change
    remove_column :genres, :post_id, :integer
  end
end
