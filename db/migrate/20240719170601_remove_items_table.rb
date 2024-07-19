class RemoveItemsTable < ActiveRecord::Migration[7.1]
  def change
    # Remove references from order_items table if they exist
    if column_exists?(:order_items, :item_id)
      remove_reference :order_items, :item, index: true, foreign_key: false
    end

    # Drop the items table
    drop_table :items, if_exists: true
  end
end
