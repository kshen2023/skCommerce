class DropProvincesTable < ActiveRecord::Migration[6.1]
  def up
    drop_table :provinces
  end

  def down
    # 如果需要支持迁移回退，可以在这里重新创建表
    create_table :provinces do |t|
      t.string :province_name
      t.string :province_description

      t.timestamps
    end
  end
end
