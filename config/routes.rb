Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#top'

  resources :users
  resources :boards, shallow: true do
    get :bookmarks, on: :collection
    resources :comments, shallow: true
    resource :bookmarks, only: %i[create destroy]
  end

  get 'login' => 'user_sessions#new', :as => :login
  post 'login' => "user_sessions#create"
  delete 'logout' => 'user_sessions#destroy', :as => :logout
end
