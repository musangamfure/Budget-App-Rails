class CategoryBill < ApplicationRecord
  belongs_to :category
  belongs_to :bill

  validates :category_id, presence: true
  validates :bill_id, presence: true
end
