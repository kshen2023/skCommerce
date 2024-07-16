class Cart < ApplicationRecord
  has_many :items, dependent: :destroy

  def total_amount
    items.sum { |item| item.product.price * item.quantity }
  end

  def calculate_taxes(province, date = Date.today)
    tax = Tax.where(province: province)
             .where("start_date <= ? AND (end_date IS NULL OR end_date >= ?)", date, date)
             .first

    return { gst: 0, pst: 0, hst: 0, total: total_amount } unless tax

    gst_amount = total_amount * tax.gst
    pst_amount = total_amount * tax.pst
    hst_amount = total_amount * tax.hst

    { gst: gst_amount, pst: pst_amount, hst: hst_amount, total: total_amount + gst_amount + pst_amount + hst_amount }
  end
end
