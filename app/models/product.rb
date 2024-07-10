class Product < ApplicationRecord
  belongs_to :sub_category
  validates :name, uniqueness: { scope: :sub_category_id }, allow_nil: true
end
