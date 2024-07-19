class Product < ApplicationRecord
  belongs_to :sub_category
  has_many :cart_items
  validates :name, uniqueness: { scope: :sub_category_id }, allow_nil: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "id_value", "img_src", "name", "price", "product_link", "sub_category_id", "updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["sub_category"]
  end
  scope :new_products, -> { where('created_at >= ?', 3.days.ago) }
  scope :recently_updated, -> {
    where('updated_at >= ?', 3.days.ago)
      .where('updated_at > created_at')
  }

end
