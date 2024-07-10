ActiveAdmin.register Product do
  permit_params :name, :description, :product_link, :price, :img_src, :sub_category_id

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :product_link
    column :price
    column :img_src
    column :sub_category
    actions
  end

  filter :name
  filter :description
  filter :product_link
  filter :price
  filter :sub_category

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :product_link
      f.input :price
      f.input :img_src
      f.input :sub_category
    end
    f.actions
  end
end
