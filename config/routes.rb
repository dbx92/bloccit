Rails.application.routes.draw do

  resources :posts

  get 'about' => 'welcome#about'

  get 'index' => 'welcome#index'

  get 'faq' => 'welcome#faq'

  root 'welcome#index'
end
