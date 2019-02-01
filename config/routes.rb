Rails.application.routes.draw do

  resources :topics do
    resources :posts, except: [:index]
    resources :sponsored_posts, except: [:index]
  end

  resources :users, only: [:new,:create]

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
