class AddUniqueIndexToProducts < ActiveRecord::Migration[7.1]
  def change
     add_index :products, [:name, :sub_category_id], unique: true, where: 'name IS NOT NULL'
  end
end
