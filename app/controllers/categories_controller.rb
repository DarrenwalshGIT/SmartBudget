
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

  # EDIT: Find the existing category that the user wants to change.
  # Rails uses the ID in the URL to retrieve it from PostgreSQL.
  def edit
    @category = Category.find(params[:id])
  end

  # UPDATE: Save changes to an existing spending category.
  def update
    # Find the category that was selected for editing.
    @category = Category.find(params[:id])

    # Update only the fields allowed by our strong parameters.
    if @category.update(category_params)
      # Redirect to the updated category's details page.
      redirect_to @category, notice: "Category updated successfully."
    else
      # Show the editing form again if validation fails.
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE: Remove an existing spending category from PostgreSQL.
  def destroy
    # Find the category using the ID included in the URL.
    @category = Category.find(params[:id])

    # Delete the category from the database.
    @category.destroy!

    # Return the user to the Categories list after deletion.
    redirect_to categories_path,
                notice: "Category deleted successfully.",
                status: :see_other
  end

  private

  # Strong parameters allow only the name and description fields
  # to be submitted when creating or updating a category.
  def category_params
    params.require(:category).permit(:name, :description)
  end
end
