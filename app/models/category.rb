class Category < ApplicationRecord
  has_many :sub_categories, dependent: :destroy

  validates :name, uniqueness: true, allow_nil: true
end
