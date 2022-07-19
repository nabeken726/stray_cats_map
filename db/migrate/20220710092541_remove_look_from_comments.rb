class RemoveLookFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :look, :integer
  end
end
