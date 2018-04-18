class AddValidationColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :validation_date, :datetime
  end
end
