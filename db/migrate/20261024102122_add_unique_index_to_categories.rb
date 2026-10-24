# Adds a database-level rule preventing duplicate category names.
# Unlike model validation, this is enforced directly by PostgreSQL.
class AddUniqueIndexToCategories < ActiveRecord::Migration[8.1]
  def change
    # LOWER(name) compares category names without regard to uppercase
    # or lowercase letters.
    #
    # A unique index prevents both "Groceries" and "groceries"
    # from existing as separate database records.
    add_index :categories,
              "LOWER(name)",
              unique: true,
              name: "index_categories_on_lower_name"
  end
end
