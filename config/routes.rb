Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :articles do
    resources :comments, only: [:index, :create, :update, :destroy]
  end
  resources :photos, only: [:index, :show, :create, :update, :destroy]
  get "up" => "rails/health#show", as: :rails_health_check
end
