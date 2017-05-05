Rails.application.routes.draw do

  devise_for :users
  root to: 'questions#index'

  resources :questions do
    resources :answers, shallow: true do
      patch :set_best, on: :member
    end
  end
  # post 'answers/set_best/:answer_id', to: 'answers#set_best', as: :best_answer
end
