Rails.application.routes.draw do

  devise_for :users
  root to: 'questions#index'

  concern :votable do
    patch :vote, on: :member
  end

  concern :commentable do
    resources :comments, shallow: true
  end

  resources :questions do
    resources :comments, shallow: true, module: :questions
    resources :answers, shallow: true do
      patch :set_best, on: :member
      concerns :votable
      resources :comments, module: :answers
    end
    concerns :votable
  end

  resources :attachments, only: [:destroy]

  mount ActionCable.server => '/cable'
end
