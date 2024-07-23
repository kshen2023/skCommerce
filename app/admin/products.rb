ActiveAdmin.register Product do
  permit_params :name, :description, :product_link, :price, :img_src, :sub_category_id, tag_ids: []

  controller do
    def update
      super do |success, failure|
        success.html do
          resource.touch if resource.changed?  # 如果资源有变更，手动更新时间戳
          redirect_to admin_products_path
        end
      end
    end
  end

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :product_link
    column :price
    column :img_src
    column :sub_category
    column :tag do |product|
      product.tags.map(&:name).join(', ')
    end
    actions
  end

  filter :name
  filter :description
  filter :product_link
  filter :price
  filter :sub_category
  filter :tag
  remove_filter :product_tags
  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :product_link
      f.input :price
      f.input :img_src
      f.input :sub_category
      f.input :tag, as: :check_boxes, collection: Tag.all
    end
    f.actions
  end
end
