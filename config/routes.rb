Rails.application.routes.draw do
  get 'users/show'
  get 'users/edit'
  root to: "homes#top"
  devise_for :users

  resource :books_controller, only: [:edit, :index, :show]
  resource :homes_controller, only: [:top, :about]
  resource :users_controller, only: [:edit, :index, :show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
