# Represents a spending category within SmartBudget.
# Examples include Groceries, Rent, Transport and Entertainment.
class Category < ApplicationRecord
  # A category can be associated with multiple transactions.
  # Prevent deletion when transactions still reference it,
  # protecting users from accidentally losing financial history.
  has_many :transactions, dependent: :restrict_with_error

  # A category must have a name.
  validates :name, presence: true

  # Prevent duplicate names, regardless of letter case.
  validates :name, uniqueness: { case_sensitive: false }
end
