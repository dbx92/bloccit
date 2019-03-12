Rails.application.routes.draw do

  resources :topics do
    resources :posts, except: [:index]
    resources :sponsored_posts, except: [:index]
  end

  resources :posts, only: [] do
    resources :comments, only: [:create, :destroy]
    post '/up-vote' => 'votes#up_vote', as: :up_vote
    post '/down-vote' => 'votes#down_vote', as: :down_vote
  end

  resources :users, only: [:new,:create]

  resources :sessions, only: [:new,:create,:destroy]

  post 'users/confirm' => 'users#confirm'

  resources :questions

  resources :advertisements

  get 'show' => 'advertisement#show'

  get 'about' => 'welcome#about'

  get 'index' => 'welcome#index'

  get 'faq' => 'welcome#faq'

  get 'posts' => 'posts#index'

  root 'welcome#index'
end
