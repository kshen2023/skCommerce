# app/models/customer.rb
class Customer < ApplicationRecord
    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :orders
belongs_to :province
def self.ransackable_associations(auth_object = nil)
  ["orders", "province"]
end
has_one_attached :image
def self.ransackable_attributes(auth_object = nil)
  ["address", "city", "created_at", "current_sign_in_at", "current_sign_in_ip", "email", "encrypted_password", "id", "id_value", "last_sign_in_at", "last_sign_in_ip", "name", "phone", "postal_code", "province_id", "remember_created_at", "reset_password_sent_at", "reset_password_token", "sign_in_count", "updated_at"]
end
  validates :name, :email, :address, :city, :province, :postal_code, :phone, presence: true
  validates :email, uniqueness: true
end
