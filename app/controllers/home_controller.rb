# Displays an overview of household finances.
class HomeController < ApplicationController
  def index
    # Calculate income and expenses from PostgreSQL transactions.
    @total_income = Transaction.where(transaction_type: "income").sum(:amount)
    @total_expenses = Transaction.where(transaction_type: "expense").sum(:amount)

    # Use the custom library for financial calculations.
    calculator = BudgetCalculator.new(
      income: @total_income,
      expenses: @total_expenses
    )

    @balance = calculator.balance
    @savings_rate = calculator.savings_rate
    @spending_percentage = calculator.spending_percentage

    # Retrieve the five most recent transactions.
    @recent_transactions = Transaction.includes(:category)
                                      .order(transaction_date: :desc, id: :desc)
                                      .limit(5)
  end
end
