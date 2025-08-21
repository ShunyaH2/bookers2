Rails.application.routes.draw do
  get 'about' => "homes#about", as: "about"
  root to: "homes#top"
  devise_for :users

  resources :books, only: [:edit, :index, :show] do
    collection do
      get :my_books
    end
  end
  resources :users, only: [:edit, :index, :show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
