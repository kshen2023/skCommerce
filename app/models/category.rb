class Category < ApplicationRecord
  has_many :sub_categories, dependent: :destroy

  validates :name, uniqueness: true, allow_nil: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "id_value", "name", "updated_at"]
  end
end
