class Tag < ApplicationRecord
  has_many :product_tags
  has_many :products, through: :product_tags



  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "name", "updated_at"]
  end
  validates :name, presence: true, uniqueness: true
end
