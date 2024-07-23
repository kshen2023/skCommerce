class ProductTag < ApplicationRecord
  belongs_to :product
  belongs_to :tag
  validates :product_id, presence: true, numericality: { only_integer: true }
  validates :tag_id, presence: true, numericality: { only_integer: true }
end
