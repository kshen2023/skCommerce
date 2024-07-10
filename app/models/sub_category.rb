class SubCategory < ApplicationRecord
  belongs_to :category
  has_many :products, dependent: :destroy

  validates :name, uniqueness: { scope: :category_id }, allow_nil: true
end
