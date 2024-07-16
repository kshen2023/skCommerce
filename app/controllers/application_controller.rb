class ApplicationController < ActionController::Base
  # helper_method :calculate_taxes

  # def calculate_taxes(province, total_amount)
  #   tax = Tax.find_by(province: province)
  #   gst_amount = total_amount * tax.gst
  #   pst_amount = total_amount * tax.pst
  #   hst_amount = total_amount * tax.hst
  #   { gst: gst_amount, pst: pst_amount, hst: hst_amount }
  # end
end
