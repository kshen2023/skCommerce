class AddUniqueIndexToSubCategories < ActiveRecord::Migration[7.1]
  def change
     add_index :sub_categories, [:name, :category_id], unique: true, where: 'name IS NOT NULL'
  end
end
