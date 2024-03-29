Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  default_url_options :host => "localhost:3000"
  
  resources :skus
  resources :products
  devise_for :users, controllers: {sessions: :sessions}, defaults: {format: :json}, path_names: {sign_in: :login, sign_out: :logout}
  resources :users
end
