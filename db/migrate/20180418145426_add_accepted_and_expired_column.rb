class AddAcceptedAndExpiredColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :accepted, :boolean
    add_column :users, :expired, :boolean
  end
end
