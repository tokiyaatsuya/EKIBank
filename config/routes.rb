Rails.application.routes.draw do
  get 'answers/show'
  get 'questions/show1'
  get 'questions/show2'
  get 'questions/show3'
  get 'questions/show4'
  get 'questions/show5'
  get 'questions/show6'
  get 'questions/show7'
  get 'questions/show8'
  get 'questions/show9'
  get 'questions/show10'
  get 'questions/show11'
  get 'questions/show12'
  get 'questions/show13'
  devise_for :users
  root 'pages#index'
  get 'pages/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
