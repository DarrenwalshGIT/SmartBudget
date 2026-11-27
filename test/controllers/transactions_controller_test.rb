require "test_helper"

# Tests the pages used to manage SmartBudget transactions.
class TransactionsControllerTest < ActionDispatch::IntegrationTest
  # The transactions page should load and display its heading.
  test "should display transactions index" do
    get transactions_path

    assert_response :success
    assert_select "h1", text: "Transactions"
  end

  # Existing transactions should appear on the page.
  test "should display saved transactions" do
    get transactions_path

    assert_response :success
    assert_select "body", text: /Weekly groceries/
    assert_select "body", text: /Monthly salary/
  end


  # Checks that a valid transaction is saved successfully.
  test "should create a transaction" do
    # Record the starting number of transactions.
    assert_difference("Transaction.count", 1) do
      post transactions_path, params: {
        transaction: {
          description: "Electricity bill",
          amount: "120.50",
          transaction_type: "expense",
          transaction_date: Date.current,
          category_id: categories(:one).id
        }
      }
    end

    # Return to the Transactions page after saving.
    assert_redirected_to transactions_path

    # Confirm the new record contains the expected details.
    transaction = Transaction.order(:id).last
    assert_equal "Electricity bill", transaction.description
    assert_equal BigDecimal("120.50"), transaction.amount
    assert_equal "expense", transaction.transaction_type
  end
end
