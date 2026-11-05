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

  # UPDATE: Verify that an existing spending category can be edited.
  # This test checks that Rails saves the revised name and
  # description to the PostgreSQL test database.
  test "should update an existing category" do
    # Use a category already provided by the test fixtures.
    category = categories(:one)

    # Send the updated information to the category's UPDATE route.
    patch category_path(category), params: {
      category: {
        name: "Updated Groceries",
        description: "Food, drinks and household essentials"
      }
    }

    # A successful update should redirect to the category details.
    assert_redirected_to category_path(category)

    # Reload the category from PostgreSQL to verify saved changes.
    category.reload

    assert_equal "Updated Groceries", category.name
    assert_equal "Food, drinks and household essentials", category.description
  end

  # DELETE: Verify that an existing category can be removed.
  # The database should contain one fewer category after deletion.
  test "should destroy an existing category" do
    # Retrieve an existing category from the test fixtures.
    category = categories(:one)

    # Verify that the DELETE request removes exactly one record.
    assert_difference("Category.count", -1) do
      delete category_path(category)
    end

    # After deletion, return the user to the Categories listing.
    assert_redirected_to categories_path

    # Confirm the deleted category no longer exists in PostgreSQL.
    assert_not Category.exists?(category.id)
  end
end
