Rails.application.routes.draw do

  resources :advertisements

  get 'show' => 'advertisement#show'

  resources :posts

  get 'about' => 'welcome#about'

  get 'index' => 'welcome#index'

  get 'faq' => 'welcome#faq'

  get 'posts' => 'posts#index'

  root 'welcome#index'
end
