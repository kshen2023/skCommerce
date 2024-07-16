# app/models/customer.rb
class Customer < ApplicationRecord
  has_many :orders
belongs_to :province
  validates :name, :email, :address, :city, :province, :postal_code, :phone, presence: true
end
