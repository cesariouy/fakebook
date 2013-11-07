FakeBook::Application.routes.draw do
  resource :session, only: [:create, :destroy, :new]

  resources :users, only: [:create, :new, :index, :show] do
    resources :posts, only: [:create, :destroy, :new]
    resources :friendships, only: [:create, :destroy]
  end

  resource :feed, only: :show

  root to: "feeds#show"
end
