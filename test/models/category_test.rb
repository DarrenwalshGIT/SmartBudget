
require "test_helper"

# Tests the validation rules for SmartBudget spending categories.
# These tests ensure that categories contain valid information
# before being saved to the PostgreSQL database.
class CategoryTest < ActiveSupport::TestCase
  # Verify that a category cannot be saved without a name.
  # This tests the presence validation in the Category model.
  test "category requires a name" do
    category = Category.new(name: nil)

    assert_not category.valid?
  end

  # Verify that two categories cannot share the same name.
  # Use a name that is different from our existing test fixtures
  # so that the test checks the rule independently.
  test "category names must be unique" do
    # Create the first category successfully.
    Category.create!(name: "Household Bills")

    # Attempt to create a second category with the same name.
    duplicate_category = Category.new(name: "Household Bills")

    # Confirm Rails identifies the duplicate as invalid.
    assert_not duplicate_category.valid?
  end
end
