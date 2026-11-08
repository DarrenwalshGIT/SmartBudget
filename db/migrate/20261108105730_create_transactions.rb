
# Creates the transactions table used to store income and expenses.
# Each transaction belongs to an existing SmartBudget category.
class CreateTransactions < ActiveRecord::Migration[8.1]
  def change
    create_table :transactions do |t|
      # A description explains what the transaction relates to.
      t.string :description, null: false

      # Store monetary amounts with two decimal places.
      # Precision 10 and scale 2 support values up to 99,999,999.99.
      t.decimal :amount, precision: 10, scale: 2, null: false

      # Identify whether the transaction is income or an expense.
      t.string :transaction_type, null: false

      # Record the date on which the transaction occurred.
      t.date :transaction_date, null: false

      # Link every transaction to a valid category.
      # PostgreSQL enforces this relationship through a foreign key.
      t.references :category, null: false, foreign_key: true

      # Automatically track when records are created or updated.
      t.timestamps
    end

    # Prevent invalid transaction amounts at the database level.
    # We store positive amounts and use transaction_type to
    # distinguish income from expenses.
    add_check_constraint :transactions, "amount > 0",
                         name: "transactions_amount_positive"

    # Only accept the two transaction types supported by SmartBudget.
    add_check_constraint :transactions,
                         "transaction_type IN ('income', 'expense')",
                         name: "transactions_type_valid"
  end
end
