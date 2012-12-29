class UserExpense
  include MongoMapper::Document

  key :amount, Float, :required => true, :numeric => true
  key :comment, String

  belongs_to :user_expense_category
  belongs_to :user
end
