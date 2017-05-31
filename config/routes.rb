Rails.application.routes.draw do

  devise_for :users
  root to: 'questions#index'

  concern :votable do
    patch :vote, on: :member
  end

  resources :questions do
    resources :answers, shallow: true do
      patch :set_best, on: :member
      concerns :votable
    end
    concerns :votable
  end

  resources :attachments, only: [:destroy]

  mount ActionCable.server => '/cable'
end
