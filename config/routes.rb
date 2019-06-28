Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts, only: :create do
    post :rank, on: :member
    get :top, on: :collection
  end

  resources :network_addresses, only: [] do
    get :shared, on: :collection
  end
end
