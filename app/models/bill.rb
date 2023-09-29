class Bill < ApplicationRecord
  has_many :category_bills, dependent: :destroy
  has_many :categories, through: :category_bills
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  has_one_attached :icon

  validates :name, presence: true
  validates :amount, presence: true, numericality: { only_float: true, greater_than_or_equal_to: 0 }
end
