class RemoveCuteFromComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :cute, :integer
  end
end
