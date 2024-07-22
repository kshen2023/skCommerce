ActiveAdmin.register Order do
  permit_params :customer_id, :total, :status, :stripe_payment_id, order_items_attributes: [:id, :order_id, :product_id, :quantity, :price, :_destroy]

  index do
    selectable_column
    id_column
    column :stripe_payment_id
    column :customer
    column :status
    column :total do |order|
      number_to_currency(order.total)
    end
    actions
  end

  show do
    attributes_table do
      row :id
      row :stripe_payment_id
      row :customer
      row :status
      row :total do |order|
        number_to_currency(order.total)
      end
      row :created_at
      row :updated_at
    end

    panel "Order Items" do
      table_for order.order_items do
        column :product
        column :quantity
        column :price do |item|
          number_to_currency(item.price)
        end
        column "Total" do |item|
          number_to_currency(item.price * item.quantity)
        end
      end
    end

    panel "Taxes" do
      attributes_table_for order do
        row :gst do |order|
          number_to_currency(order.gst)
        end
        row :pst do |order|
          number_to_currency(order.pst)
        end
        row :hst do |order|
          number_to_currency(order.hst)
        end
      end
    end
  end

  form do |f|
    f.inputs "Order Details" do
      f.input :customer
      f.input :status
      f.input :total
      f.input :stripe_payment_id
    end

    f.inputs "Order Items" do
      f.has_many :order_items, allow_destroy: true, new_record: true do |item|
        item.input :product
        item.input :quantity
        item.input :price
      end
    end

    f.actions
  end

  filter :stripe_payment_id, as: :string
  filter :customer
  filter :status
  filter :total
end
