class TableUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :email, :string
    add_column :users, :password, :string
    add_column :users, :phone_number, :string
    add_column :users, :biography, :text
    add_column :users, :is_verified, :boolean
  end
end
