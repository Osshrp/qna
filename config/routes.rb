require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  use_doorkeeper
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }
  root to: 'questions#index'

  devise_scope :user do
    post 'new_email', to: 'omniauth_callbacks#new_email', as: :new_user_email
  end

  concern :votable do
    patch :vote, on: :member
  end

  concern :commentable do
    resources :comments, shallow: true
  end

  resources :questions do
    resources :comments, shallow: true, module: :questions
    resources :subscriptions, shallow: true, only: [:create, :destroy]
    resources :answers, shallow: true do
      patch :set_best, on: :member
      concerns :votable
      resources :comments, module: :answers
    end
    concerns :votable
  end

  resources :attachments, only: [:destroy]

  namespace :api do
    namespace :v1 do
      resource :profiles do
        get :me, on: :collection
        get :index, on: :collection
      end
      resources :questions do
        resources :answers, shallow: true
      end
    end
  end

  resource :search, only: :show

  mount ActionCable.server => '/cable'
end
