Pet::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  root :to => 'welcome#index'
  match 'login' => 'welcome#login', :as => :login
  match 'change_password' => 'welcome#change_password', :as => :change_pass
  match 'logout' => 'welcome#logout', :as => :logout

  match 'show-budget' => 'main#show_budget', :as => :show_budget
  match 'create-budget' => 'main#create_budget', :as => :create_budget

  match 'new-expense' => 'main#new_expense', :as => :new_expense
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
