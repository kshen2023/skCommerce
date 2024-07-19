class RemoveItemReferenceFromOrderItems < ActiveRecord::Migration[7.1]
  def change
    remove_reference :order_items, :item, index: true, foreign_key: false
  end
end
