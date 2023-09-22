class Category < ApplicationRecord
  has_many :category_bills, dependent: :destroy
  has_many :bills, through: :category_bills
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  has_one_attached :icon

  validates :name, presence: true
end
