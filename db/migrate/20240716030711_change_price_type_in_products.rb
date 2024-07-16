class ChangePriceTypeInProducts < ActiveRecord::Migration[7.1]
  def up
    change_column :products, :price, :string
  end

  def down
    change_column :products, :price, :decimal
  end
end
