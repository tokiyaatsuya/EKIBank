Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'
  get 'pages/show'
  resources :questions do
    collection do
      get 'show_1'
      post 'show_1', to: 'questions#show_1'
      get 'show_2'
      post 'show_2', to: 'questions#show_2'
      get 'show_3'
      post 'show_3', to: 'questions#show_3'
      get 'show_4'
      post 'show_4', to: 'questions#show_4'
      get 'show_5'
      post 'show_5', to: 'questions#show_5'
      get 'show_6'
      post 'show_6', to: 'questions#show_6'
      get 'show_7'
      post 'show_7', to: 'questions#show_7'
      get 'show_8'
      post 'show_8', to: 'questions#show_8'
      get 'show_9'
      post 'show_9', to: 'questions#show_9'
      get 'show_10'
      post 'show_10', to: 'questions#show_10'
      get 'show_11'
      post 'show_11', to: 'questions#show_11'
      get 'show_12'
      post 'show_12', to: 'questions#show_12'
      get 'answer/show'
      post 'answer/show', to: 'answers#show'
    end
  end
end
