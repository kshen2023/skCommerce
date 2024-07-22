class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy
  def self.ransackable_associations(auth_object = nil)
    ["customer", "order_items"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "customer_id", "id", "id_value", "status", "total", "updated_at","stripe_payment_id"]
  end

  def subtotal
    order_items.sum { |item| item.price * item.quantity }
  end

  def gst
    customer.province.gst_rate * subtotal
  end

  def pst
    customer.province.pst_rate * subtotal
  end

  def hst
    customer.province.hst_rate * subtotal
  end


  def total_taxes
    gst + pst + hst
  end

  def total_amount
    subtotal + total_taxes
  end
end
