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
end
