Rails.application.routes.draw do

  devise_for :users
  root to: 'questions#index'

  resources :questions do
    resources :answers, shallow: true do
      patch :set_best, on: :member
    end
    patch :set_like, on: :member
  end

  resources :attachments, only: [:destroy]
end
