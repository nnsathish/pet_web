class BudgetExpense
  include MongoMapper::Document

  key :amount, Float, :required => true, :numeric => true

  belongs_to :user_expense_category
  belongs_to :budget
end
