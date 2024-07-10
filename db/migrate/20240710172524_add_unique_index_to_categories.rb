class AddUniqueIndexToCategories < ActiveRecord::Migration[7.1]
  def change
    add_index :categories, :name, unique: true, where: 'name IS NOT NULL'
  end
end
