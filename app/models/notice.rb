class Notice < ApplicationRecord
  belongs_to :comment
  belongs_to :user

  validates :status, numericality: { greater_than: 0 , less_than: 3 }
end
