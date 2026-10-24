# Represents a spending category within SmartBudget.
# Examples include Groceries, Rent, Transport and Entertainment.
#
# Inheriting from ApplicationRecord provides Active Record
# functionality for interacting with the PostgreSQL database.
class Category < ApplicationRecord
  # A category must have a name.
  # The presence validation rejects nil, empty or blank names.
  validates :name, presence: true

  # Prevent duplicate category names, regardless of letter case.
  # For example, "Groceries" and "groceries" are considered duplicates.
  validates :name, uniqueness: { case_sensitive: false }
end
