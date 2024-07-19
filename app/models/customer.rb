# app/models/customer.rb
class Customer < ApplicationRecord
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders
belongs_to :province
  validates :name, :email, :address, :city, :province, :postal_code, :phone, presence: true
  validates :email, uniqueness: true
end
