class AddUserRefToBills < ActiveRecord::Migration[7.0]
  def change
    add_reference :bills, :user, null: false, foreign_key: { to_table: 'users' }
  end
end
