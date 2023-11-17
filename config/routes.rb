Rails.application.routes.draw do
  devise_for :users
   root "foods#index"
get "users/general_shopping_list"
  resources :foods, except: :update
  resources :recipes, except: :update do
    member do
      put :toggle_public
    end
    resources :recipe_foods, only: [:index, :new, :create, :destroy]
  end
  get '/public_recipes', to: 'public_recipes#index', as: 'public_recipes'
end

