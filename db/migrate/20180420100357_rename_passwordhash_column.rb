class RenamePasswordhashColumn < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :password_hash, :password
  end
end
