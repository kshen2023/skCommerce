class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :products, dependent: :destroy

  validates :name, uniqueness: { scope: :category_id }, allow_nil: true

  def self.ransackable_attributes(auth_object = nil)
    ["category_id", "created_at", "description", "id", "id_value", "name", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["category", "products"]
  end
end
