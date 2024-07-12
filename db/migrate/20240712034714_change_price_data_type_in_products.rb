class ChangePriceDataTypeInProducts < ActiveRecord::Migration[7.1]
  def change
    change_column :products, :price, :string
  end
end
