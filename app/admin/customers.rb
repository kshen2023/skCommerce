ActiveAdmin.register Customer do
  permit_params :name, :email, :address, :city, :postal_code, :phone, :province_id, :image

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :address
      f.input :city
      f.input :postal_code
      f.input :phone
      f.input :province
      f.input :image, as: :file
    end
    f.actions
  end

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :address
    column :city
    column :postal_code
    column :phone
    column :province
    column "Image" do |customer|
      if customer.image.attached?
        image_tag url_for(customer.image), size: "50x50"
      else
        "No image uploaded"
      end
    end
    actions
  end

  filter :name
  filter :email
  filter :address
  filter :city
  filter :postal_code
  filter :phone
  filter :province

  show do
    attributes_table do
      row :name
      row :email
      row :address
      row :city
      row :postal_code
      row :phone
      row :province
      row :image do |customer|
        if customer.image.attached?
          image_tag url_for(customer.image)
        else
          "No image uploaded"
        end
      end
    end
    active_admin_comments
  end
end
