class Province < ApplicationRecord
  has_many :customers


  validates :province_name, presence: true
  validates :gst_rate, presence: true, numericality: true
  validates :hst_rate, presence: true, numericality: true
  validates :pst_rate, presence: true, numericality: true

end
