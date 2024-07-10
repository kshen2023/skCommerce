class Product < ApplicationRecord
  belongs_to :sub_category

  # validates :name, :price, presence: true
end
