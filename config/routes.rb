Rails.application.routes.draw do
  devise_for :users
  resources :articles do
    resources :comments
  end

  root 'articles#index'
end
