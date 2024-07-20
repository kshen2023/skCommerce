ActiveAdmin.register Customer do
  permit_params :email, :name, :address, :city, :postal_code, :phone, :province_id

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :email
      row :name
      row :address
      row :city
      row :postal_code
      row :phone
      row :province
      row :created_at
      row :updated_at
    end

    panel "Orders" do
      table_for customer.orders do
        column :id
        column :status
        column :total do |order|
          number_to_currency(order.total)
        end
        column :created_at
        column "Details" do |order|
          link_to "View", admin_order_path(order)
        end
      end
    end
  end

  form do |f|
    f.inputs "Customer Details" do
      f.input :email
      f.input :name
      f.input :address
      f.input :city
      f.input :postal_code
      f.input :phone
      f.input :province
    end
    f.actions
  end
end
