class Province < ApplicationRecord
  has_many :customers
  has_many :taxes

  validates :province_name, presence: true, uniqueness: true
  validates :province_description, presence: true
end
