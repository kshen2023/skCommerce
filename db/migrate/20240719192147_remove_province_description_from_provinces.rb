class RemoveProvinceDescriptionFromProvinces < ActiveRecord::Migration[7.1]
  def change
    remove_column :provinces, :province_description, :string
  end
end
