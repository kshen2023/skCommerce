class Product < ApplicationRecord
  belongs_to :sub_category
  validates :name, uniqueness: { scope: :sub_category_id }, allow_nil: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "id_value", "img_src", "name", "price", "product_link", "sub_category_id", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["sub_category"]
  end
end
