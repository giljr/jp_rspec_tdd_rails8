Rails.application.routes.draw do
  devise_for :members
  resources :customers #, only: [:index, :new]

  root "welcome#index"
end
