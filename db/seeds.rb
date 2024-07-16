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
alberta = Province.find_or_create_by(province_name: 'Alberta', province_description: 'Province in western Canada')
bc = Province.find_or_create_by(province_name: 'British Columbia', province_description: 'Province on the west coast of Canada')
manitoba = Province.find_or_create_by(province_name: 'Manitoba', province_description: 'Province in central Canada')
ontario = Province.find_or_create_by(province_name: 'Ontario', province_description: 'Province in east-central Canada')
quebec = Province.find_or_create_by(province_name: 'Quebec', province_description: 'Province in east-central Canada')
saskatchewan = Province.find_or_create_by(province_name: 'Saskatchewan', province_description: 'Province in central Canada')
newfoundland = Province.find_or_create_by(province_name: 'Newfoundland and Labrador', province_description: 'Province in eastern Canada')
nova_scotia = Province.find_or_create_by(province_name: 'Nova Scotia', province_description: 'Province in eastern Canada')
new_brunswick = Province.find_or_create_by(province_name: 'New Brunswick', province_description: 'Province in eastern Canada')
prince_edward_island = Province.find_or_create_by(province_name: 'Prince Edward Island', province_description: 'Province in eastern Canada')
northwest_territories = Province.find_or_create_by(province_name: 'Northwest Territories', province_description: 'Territory in northern Canada')
nunavut = Province.find_or_create_by(province_name: 'Nunavut', province_description: 'Territory in northern Canada')
yukon = Province.find_or_create_by(province_name: 'Yukon', province_description: 'Territory in northwestern Canada')


alberta_tax = Tax.find_or_create_by(gst: 0.05, pst: 0, hst: 0, start_date: '2023-01-01')
bc_tax = Tax.find_or_create_by(gst: 0.05, pst: 0.07, hst: 0, start_date: '2023-01-01')
manitoba_tax = Tax.find_or_create_by(gst: 0.05, pst: 0.07, hst: 0, start_date: '2023-01-01')
ontario_tax = Tax.find_or_create_by(gst: 0, pst: 0, hst: 0.13, start_date: '2023-01-01')
quebec_tax = Tax.find_or_create_by(gst: 0.05, pst: 0.09975, hst: 0, start_date: '2023-01-01')
new_brunswick_tax = Tax.find_or_create_by( gst: 0, pst: 0, hst: 0.15, start_date: '2023-01-01')
newfoundland_labrador_tax = Tax.find_or_create_by( gst: 0, pst: 0, hst: 0.15, start_date: '2023-01-01')
northwest_territories_tax = Tax.find_or_create_by( gst: 0.05, pst: 0, hst: 0, start_date: '2023-01-01')
nova_scotia_tax = Tax.find_or_create_by(gst: 0, pst: 0, hst: 0.15, start_date: '2023-01-01')
nunavut_tax = Tax.find_or_create_by(gst: 0.05, pst: 0, hst: 0, start_date: '2023-01-01')
pei_tax = Tax.find_or_create_by(gst: 0, pst: 0, hst: 0.15, start_date: '2023-01-01')
saskatchewan_tax = Tax.find_or_create_by(gst: 0.05, pst: 0.06, hst: 0, start_date: '2023-01-01')
yukon_tax = Tax.find_or_create_by(gst: 0.05, pst: 0, hst: 0, start_date: '2023-01-01')


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
# AdminUser.create!(email: 'kshen@rrc.ca', password: 'password', password_confirmation: 'password') if Rails.env.development?
