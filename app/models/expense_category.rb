class ExpenseCategory
  include MongoMapper::Document

  key :name, String, :required => true, :unique => true, :length => 5..15

  DEFAULT => [
    :groceries, :electricity, :water, :home_maintanence, :life_insurance,
    :automobile_maintanence, :rent, :property_tax, :medical, :donations,
    :loans, :stocks, :entertainment, :shopping, :education, :fixed_deposits,
    :travel, :fuel, :saloon, :mobiles, :broadband, :parties, :recurring_deposits,
    :dth, :credit_cards, :restaurants, :laundry, :clubs, :gifts, :cable_tv
  ]
end
