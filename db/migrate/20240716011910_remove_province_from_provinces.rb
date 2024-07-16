class RemoveProvinceFromProvinces < ActiveRecord::Migration[7.1]
  def change
    remove_column :provinces, :province, :string
  end
end
