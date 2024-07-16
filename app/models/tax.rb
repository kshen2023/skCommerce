
class Tax < ApplicationRecord
  belongs_to :province


  validates :gst, numericality: { greater_than_or_equal_to: 0 }
  validates :pst, numericality: { greater_than_or_equal_to: 0 }
  validates :hst, numericality: { greater_than_or_equal_to: 0 }
end
