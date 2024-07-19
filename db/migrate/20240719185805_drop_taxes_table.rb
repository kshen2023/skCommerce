class DropTaxesTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :taxes
  end
end
