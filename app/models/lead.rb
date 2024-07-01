class Lead < ApplicationRecord
  # Presence validations
  validates :address, :loan_term, :purchase_price, :repair_budget, :arv, :name, :email, :phone, presence: true

  # Numericality validations
  validates :loan_term, numericality: {only_integer: true, greater_than: 0, less_than_or_equal_to: 12, message: "must be between 1 and 12 months"}
  validates :purchase_price, :repair_budget, :arv, numericality: {greater_than: 0, message: "must be a positive number"}
end
