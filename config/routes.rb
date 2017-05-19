Rails.application.routes.draw do

  devise_for :users
  root to: 'questions#index'

  resources :questions do
    resources :answers, shallow: true do
      patch :set_best, on: :member
      patch :vote, on: :member
    end
    patch :vote, on: :member
  end

  resources :attachments, only: [:destroy]
end
