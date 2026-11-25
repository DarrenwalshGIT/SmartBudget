require "test_helper"
require Rails.root.join("lib/budget_calculator")

# Tests financial calculations used by SmartBudget.
class BudgetCalculatorTest < ActiveSupport::TestCase
  # The balance should equal income minus expenses.
  test "calculates the remaining balance" do
    calculator = BudgetCalculator.new(
      income: 2500,
      expenses: 850
    )

    assert_equal 1650, calculator.balance
  end

  # Calculates the percentage of income remaining after expenses.
  test "calculates the savings rate" do
    calculator = BudgetCalculator.new(
      income: 2500,
      expenses: 850
    )

    assert_equal 66.0, calculator.savings_rate
  end

  # Returns a zero savings rate when there is no income.
  test "returns zero savings rate when income is zero" do
    calculator = BudgetCalculator.new(
      income: 0,
      expenses: 500
    )

    assert_equal 0.0, calculator.savings_rate
  end

  # Calculates how much income has been spent as a percentage.
  test "calculates the spending percentage" do
    calculator = BudgetCalculator.new(
      income: 2500,
      expenses: 850
    )

    assert_equal 34.0, calculator.spending_percentage
  end

  # Returns zero spending percentage when there is no income.
  test "returns zero spending percentage when income is zero" do
    calculator = BudgetCalculator.new(
      income: 0,
      expenses: 500
    )

    assert_equal 0.0, calculator.spending_percentage
  end
end
