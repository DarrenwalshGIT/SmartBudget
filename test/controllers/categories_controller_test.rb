require "test_helper"

# Tests that SmartBudget's Categories controller responds
# correctly to requests made by users through the website.
class CategoriesControllerTest < ActionDispatch::IntegrationTest
  # Verify that visiting the categories page succeeds
  # and displays the heading for category management.
  test "should display the categories index" do
    # Send a GET request to the categories listing URL.
    get "/categories"

    # Confirm that the server responds with HTTP 200 (success).
    assert_response :success

    # Check that the page includes the expected heading.
    assert_select "h1", text: "Categories"
  end


  # CREATE: Check that submitting valid category information
  # saves a new record to PostgreSQL and redirects to its page.
  test "should create a category" do
    # The database should contain one additional category
    # after the POST request is processed.
    assert_difference("Category.count", 1) do
      post categories_path, params: {
        category: {
          name: "Healthcare",
          description: "Medical and pharmacy expenses"
        }
      }
    end

    # After creating the category, Rails should redirect
    # the user to the newly created category's details page.
    assert_redirected_to category_path(Category.last)
  end
end
