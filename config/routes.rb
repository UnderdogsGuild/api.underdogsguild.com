Rails.application.routes.draw do
  resources :sessions
  resources :forum_posts
  resources :forum_threads
  resources :forums
  resources :forum_categories
  resources :registration_tokens
  resources :password_reminders
  scope '/api/v1' do
    resources :users, :roles
    resources :permissions, param: :internal_name do
      resources :roles, only: [:index]
      resources :users, :path => :direct_users, only: [:index]
      resources :users, :path => :indirect_users, only: [:index]
      resources :users, :path => :all_users, only: [:index]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
