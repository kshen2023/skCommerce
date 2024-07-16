class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :address
      t.string :city
      t.integer :province_id
      t.string :postal_code
      t.references :province, null: false, foreign_key: true
      t.timestamps
    end

  end
end
