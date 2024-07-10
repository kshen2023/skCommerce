# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'csv'

csv_file_path = Rails.root.join('db', 'seeds', 'NIKE.csv')

CSV.foreach(csv_file_path, headers: true) do |row|
  category_name = row['category']
  sub_category_name = row['sub-category']
  product_name = row['name']
  product_price = row['price']
  product_description = row['description']
  product_link = row['product-link']
  img_src = row['img-src']

  # 查找或创建类别
  category = Category.find_or_create_by!(name: category_name) do |cat|
    cat.description = row['category-href']
  end

  # 查找或创建子类别
  sub_category = SubCategory.find_or_create_by!(name: sub_category_name, category: category) do |sub_cat|
    sub_cat.description = row['sub-category-href']
  end

  # 查找或创建产品
  Product.find_or_create_by!(name: product_name, sub_category: sub_category) do |product|
    product.description = product_description
    product.product_link = product_link
    product.price = product_price
    product.img_src = img_src
  end
end
