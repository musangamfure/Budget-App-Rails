class CreateCategoryBills < ActiveRecord::Migration[7.0]
  def change
    create_table :category_bills do |t|
      t.references :category, null: false, foreign_key: true
      t.references :bill, null: false, foreign_key: true

      t.timestamps
    end
  end
end
