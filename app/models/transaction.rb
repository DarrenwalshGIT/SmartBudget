# Represents an income or expense recorded in SmartBudget.
# Every transaction belongs to an existing spending category.
class Transaction < ApplicationRecord
  # Establish the relationship between transactions and categories.
  # Rails requires each transaction to have an associated category.
  belongs_to :category

  # Require a description explaining what the transaction was for.
  validates :description, presence: true

  # Require a positive monetary amount for income and expenses.
  # We use transaction_type to distinguish between the two.
  validates :amount, presence: true,
                     numericality: { greater_than: 0 }

  # Only allow the two transaction types supported by SmartBudget.
  # Any other value, including "transfer" or nil, is invalid.
  validates :transaction_type, inclusion: { in: %w[income expense] }

  # Require a date so transactions can be organised
  # and included in future budget reports.
  validates :transaction_date, presence: true
end
