class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy

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
