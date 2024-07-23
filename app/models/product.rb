class Product < ApplicationRecord

  belongs_to :sub_category
  has_many :cart_items
  has_many :product_tags
  has_many :tags, through: :product_tags
  validates :name, presence: true
  validates :description, presence: true
  validates :product_link, presence: true
  validates :price, presence: true, numericality: true
  validates :img_src, presence: true
  validates :sub_category_id, presence: true, numericality: { only_integer: true }

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "description", "id", "id_value", "img_src", "name", "price", "product_link", "sub_category_id", "tag_id","updated_at"]
  end
  def self.ransackable_associations(auth_object = nil)
    ["sub_category","tag"]
  end
  scope :new_products, -> { where('created_at >= ?', 3.days.ago) }
  scope :recently_updated, -> {
    where('updated_at >= ?', 3.days.ago)
      .where('updated_at > created_at')
  }

end
