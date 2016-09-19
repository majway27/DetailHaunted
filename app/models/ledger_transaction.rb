class LedgerTransaction < ApplicationRecord
  belongs_to :user
  
  validates :transaction_id, presence: true, numericality: { only_integer: true }
  validates :amount, numericality: true
  
end
