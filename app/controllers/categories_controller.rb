# Handles requests for managing SmartBudget spending categories.
class CategoriesController < ApplicationController
  # READ: Retrieve all categories from PostgreSQL.
  # Order them alphabetically so the list is easy to navigate.
  def index
    @categories = Category.order(:name)
  end
end
