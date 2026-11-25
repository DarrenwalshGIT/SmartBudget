# Provides reusable financial calculations for SmartBudget.
class BudgetCalculator
  def initialize(income:, expenses:)
    @income = income
    @expenses = expenses
  end

  # Calculates the money remaining after expenses.
  def balance
    @income - @expenses
  end

  # Calculates the percentage of income remaining after expenses.
  def savings_rate
    return 0.0 if @income.zero?

    (balance.to_f / @income * 100).round(2)
  end

  # Calculates the percentage of income spent.
  def spending_percentage
    return 0.0 if @income.zero?

    (@expenses.to_f / @income * 100).round(2)
  end
end
