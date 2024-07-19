class RemoveTaxIdFromOrderItems < ActiveRecord::Migration[7.1]
  def change
    remove_column :order_items, :tax_id, :integer
  end
end
