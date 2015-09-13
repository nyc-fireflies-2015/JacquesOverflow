Rails.application.routes.draw do

  root 'questions#index'

  get '/login' => 'sessions#new'
  post '/sessions' => 'sessions#create'
  delete '/logout' => 'sessions#destroy' 

  resources :questions do 
    resources :answers, except: [:new, :index, :show]
    resources :comments, only: [:create, :destroy]
    resources :votes, only: [:destroy, :create]
  end  

  get '/trending' => 'questions#trending'
  get '/votes' => 'questions#votes'
  get '/recent' => 'questions#index'
  get '/bestanswer' => 'answers#best'

  resources :answers, only: [:show] do 
    resources :comments, only: [:create, :destroy]
    resources :votes, only: [:destroy, :create]
  end  

  resources :users, except: [:index, :show, :new]
  get '/register' => 'users#new'
  get '/profile/:id' => 'users#show', as: 'profile'

end
