# ApplicationRecord is the base class for SmartBudget's database models.
# It inherits Rails Active Record functionality for database operations.
class ApplicationRecord < ActiveRecord::Base
  # Marks ApplicationRecord as an abstract class.
  # Rails should not create a separate database table for this class.
  primary_abstract_class
end
