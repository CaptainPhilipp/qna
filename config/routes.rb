Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  devise_scope :users do
    post :email, controller: :omniauth_callbacks, as: :set_user_email
  end

  concern :rateable do
    post 'vote/:value', action: :vote, as: :vote, on: :member
  end

  concern :commentable do
    resources :comments, only: [:create]
  end

  resources :questions, concerns: %i(rateable commentable) do
    resources :answers, {
        only: %i(new create show update destroy),
        concerns: %i(rateable commentable),
        shallow: true
      } do
          patch :best, on: :member
        end
  end

  root 'questions#index'

  mount ActionCable.server => '/cable'
end
