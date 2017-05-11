Rails.application.routes.draw do
  devise_for :users

  resources :questions do
    resources :answers, only: %i(new create show update destroy), shallow: true
  end

  root 'questions#index'
end
