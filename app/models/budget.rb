class Budget
  include MongoMapper::Document

  key :total_income, Float, :required => true, :numeric => true

  belongs_to :user
  has_many :budget_expenses
end
