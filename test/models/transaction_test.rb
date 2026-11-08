# Test the business rules for SmartBudget transactions.
# These tests run against the separate PostgreSQL test database.
require "test_helper"

class TransactionTest < ActiveSupport::TestCase
  # TEST 1: Every transaction must have a description.
  # This ensures users can identify what their money was spent on.
  test "transaction requires a description" do
    # Build a transaction associated with an existing category.
    transaction = Transaction.new(
      description: "Weekly groceries",
      amount: 85.50,
      transaction_type: "expense",
      transaction_date: Date.current,
      category: categories(:one)
    )

    # Remove the description to simulate invalid user input.
    transaction.description = nil

    # Verify that Rails rejects the missing description.
    assert_not transaction.valid?
    assert_includes transaction.errors[:description], "can't be blank"
  end

  # TEST 2: Transaction amounts must be greater than zero.
  # Both income and expenses are recorded as positive values.
  test "transaction amount must be positive" do
    # Build a transaction with an invalid amount of zero.
    transaction = Transaction.new(
      description: "Weekly groceries",
      amount: 0,
      transaction_type: "expense",
      transaction_date: Date.current,
      category: categories(:one)
    )

    # Verify that Rails rejects zero as an amount.
    assert_not transaction.valid?
    assert_includes transaction.errors[:amount], "must be greater than 0"

    # Change the amount to a negative value.
    transaction.amount = -20

    # Verify that negative amounts are also rejected.
    assert_not transaction.valid?
    assert_includes transaction.errors[:amount], "must be greater than 0"
  end

  # TEST 3: Transaction types must be either income or expense.
  # Unsupported transaction types must be rejected.
  test "transaction requires a valid type" do
    # Build a transaction with an unsupported type.
    transaction = Transaction.new(
      description: "Weekly groceries",
      amount: 85.50,
      transaction_type: "transfer",
      transaction_date: Date.current,
      category: categories(:one)
    )

    # Verify that Rails rejects the unsupported type.
    assert_not transaction.valid?
    assert_includes transaction.errors[:transaction_type],
                    "is not included in the list"

    # Remove the transaction type completely.
    transaction.transaction_type = nil

    # Verify that a missing type is also rejected.
    assert_not transaction.valid?
  end

  # TEST 4: Every transaction must have a date.
  # Dates allow SmartBudget to organise spending over time.
  test "transaction requires a date" do
    # Build a transaction without a date.
    transaction = Transaction.new(
      description: "Weekly groceries",
      amount: 85.50,
      transaction_type: "expense",
      transaction_date: nil,
      category: categories(:one)
    )

    # Verify that Rails rejects the missing date.
    assert_not transaction.valid?
    assert_includes transaction.errors[:transaction_date],
                    "can't be blank"
  end
end
