class AddTaxIdToOrderItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :order_items, :tax, type: :integer, foreign_key: true
  end
end
