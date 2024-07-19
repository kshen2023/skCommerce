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
# Seed taxes with province references
# Seed provinces with descriptions
alberta = Province.find_or_create_by(
  province_name: 'Alberta',
  gst_rate: 0.05,
  pst_rate: 0,
  hst_rate: 0,

)

bc = Province.find_or_create_by(
  province_name: 'British Columbia',
  gst_rate: 0.05,
  pst_rate: 0.07,
  hst_rate: 0

)

manitoba = Province.find_or_create_by(
  province_name: 'Manitoba',
  gst_rate: 0.05,
  pst_rate: 0.07,
  hst_rate: 0

)

ontario = Province.find_or_create_by(
  province_name: 'Ontario',
  gst_rate: 0,
  pst_rate: 0,
  hst_rate: 0.13

)

quebec = Province.find_or_create_by(
  province_name: 'Quebec',
  gst_rate: 0.05,
  pst_rate: 0,
  hst_rate: 0

)

saskatchewan = Province.find_or_create_by(
  province_name: 'Saskatchewan',
  gst_rate: 0.05,
  pst_rate: 0.06,
  hst_rate: 0

)

newfoundland = Province.find_or_create_by(
  province_name: 'Newfoundland and Labrador',
  gst_rate: 0,
  pst_rate: 0,
  hst_rate: 0.15

)

nova_scotia = Province.find_or_create_by(
  province_name: 'Nova Scotia',
  gst_rate: 0,
  pst_rate: 0,
  hst_rate: 0.15

)

new_brunswick = Province.find_or_create_by(
  province_name: 'New Brunswick',
  gst_rate: 0,
  pst_rate: 0,
  hst_rate: 0.15

)

prince_edward_island = Province.find_or_create_by(
  province_name: 'Prince Edward Island',
  gst_rate: 0,
  pst_rate: 0,
  hst_rate: 0.15

)

northwest_territories = Province.find_or_create_by(
  province_name: 'Northwest Territories',
  gst_rate: 0.05,
  pst_rate: 0,
  hst_rate: 0

)

nunavut = Province.find_or_create_by(
  province_name: 'Nunavut',
  gst_rate: 0.05,
  pst_rate: 0,
  hst_rate: 0

)

yukon = Province.find_or_create_by(
  province_name: 'Yukon',
  gst_rate: 0.05,
  pst_rate: 0,
  hst_rate: 0

)



csv_file_path = Rails.root.join('db', 'seeds', 'NIKE.csv')

CSV.foreach(csv_file_path, headers: true) do |row|
  category_name = row['category']
  sub_category_name = row['sub-category']
  product_name = row['name']
  raw_price = row['price'].to_s.strip
  product_price = raw_price.gsub(/[^\d.]/, '')  # 确保 price 字段是字符串

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
# AdminUser.create!(email: 'gilbert@rrc.ca', password: 'password', password_confirmation: 'password') if Rails.env.development?
