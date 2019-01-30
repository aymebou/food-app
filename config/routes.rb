Rails.application.routes.draw do
  resources :types
  resources :foods

  match '/mealplanner', :to => "dashboard#show", :via => [:get]

  get 'updatefood', to: 'foods#update_all'
  get 'api/food/', to: 'foods#get_food_json'

  root to: redirect("/mealplanner")
end
