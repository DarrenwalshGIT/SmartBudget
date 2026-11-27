# Manages income and expense transactions in SmartBudget.
class TransactionsController < ApplicationController
  # Displays transactions in order of their date, newest first.
  def index
    @transactions = Transaction.includes(:category)
                               .order(transaction_date: :desc, id: :desc)
  end

  # Prepares a new transaction and loads categories for the form.
  def new
    @transaction = Transaction.new
    @categories = Category.order(:name)
  end

  # Saves a new income or expense transaction.
  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      redirect_to transactions_path,
                  notice: "Transaction added successfully."
    else
      # Preserve the form details and display any validation errors.
      @categories = Category.order(:name)
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Limits submitted data to the fields used by transactions.
  def transaction_params
    params.require(:transaction).permit(
      :description,
      :amount,
      :transaction_type,
      :transaction_date,
      :category_id
    )
  end
end
