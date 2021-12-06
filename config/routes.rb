Rails.application.routes.draw do
  devise_for :users
  root 'pages#index'
  get 'pages/show'
  resources :questions do
    collection do
      get 'show1'
      post 'show1', to: 'questions#show1'
      get 'show2'
      post 'show2', to: 'questions#show2'
      get 'show3'
      post 'show3', to: 'questions#show3'
      get 'show4'
      post 'show4', to: 'questions#show4'
      get 'show5'
      post 'show5', to: 'questions#show5'
      get 'show6'
      post 'show6', to: 'questions#show6'
      get 'show7'
      post 'show7', to: 'questions#show7'
      get 'show8'
      post 'show8', to: 'questions#show8'
      get 'show9'
      post 'show9', to: 'questions#show9'
      get 'show10'
      post 'show10', to: 'questions#show10'
      get 'show11'
      post 'show11', to: 'questions#show11'
      get 'show12'
      post 'show12', to: 'questions#show12'
      get 'show13'
      post 'show13', to: 'questions#show13'
      get 'answer/show'
      post 'answers/show', to: 'answers#show'
    end
  end
end
