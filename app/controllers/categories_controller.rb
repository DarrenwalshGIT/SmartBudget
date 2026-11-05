
# Handles requests for managing SmartBudget spending categories.
# Each action corresponds to a page or operation in Categories CRUD.
class CategoriesController < ApplicationController
  # READ: Retrieve categories from PostgreSQL in alphabetical order.
  def index
    @categories = Category.order(:name)
  end

  # NEW: Prepare an empty Category object for the creation form.
  def new
    @category = Category.new
  end

  # CREATE: Save a new category using the submitted form information.
  def create
    # Build a Category using only the permitted form fields.
    @category = Category.new(category_params)

    if @category.save
      # Redirect to the new category's details page after saving.
      redirect_to @category, notice: "Category created successfully."
    else
      # Redisplay the form if Rails validations reject the data.
      render :new, status: :unprocessable_entity
    end
  end

  # SHOW: Retrieve the category identified by the URL.
  def show
    @category = Category.find(params[:id])
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end
end
