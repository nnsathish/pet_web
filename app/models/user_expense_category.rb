class UserExpenseCategory
  include MongoMapper::Document

  belongs_to :user
  belongs_to :expense_category
end
