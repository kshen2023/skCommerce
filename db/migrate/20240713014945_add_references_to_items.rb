# db/migrate/[timestamp]_add_references_to_items.rb
class AddReferencesToItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :items, :cart, null: false, foreign_key: true


  end
end
