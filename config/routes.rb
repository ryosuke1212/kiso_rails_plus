Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#top'

  resources :users
  resources :boards, shallow: true do
    get :bookmarks, on: :collection
    resources :comments, shallow: true
    resource :bookmarks, only: %i[create destroy]
  end

  namespace :admin do
    resources :users, only: %i[index edit update show destroy]
    resources :boards, only: %i[index edit update show destroy]
    root to: 'dashboards#index'
    get 'login', to: 'user_sessions#new'
    post 'login', to: 'user_sessions#create'
    delete 'logout', to: 'user_sessions#destroy'
  end
  
  resource :profile, only: %i[show edit update]
  resources :password_resets, only: %i[new create edit update]
  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout
end
