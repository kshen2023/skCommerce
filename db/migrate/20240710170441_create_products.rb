class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.string :product_link
      t.decimal :price
      t.string :img_src
      t.references :sub_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
