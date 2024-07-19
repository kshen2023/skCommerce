class AddProvinceToTaxes < ActiveRecord::Migration[7.1]
  def change
    add_reference :taxes, :province, foreign_key: true
  end
end
