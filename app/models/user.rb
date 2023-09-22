class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :categories, class_name: 'Category', dependent: :destroy, foreign_key: 'user_id'
  has_many :bills, class_name: 'Bill', dependent: :destroy, foreign_key: 'user_id'

  validates :name, presence: true
end
