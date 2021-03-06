Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "hotels#index"
  resources :users, except: [:index, :destroy, :new]
  resources :hotels, except: :destroy
  post 'sign_in' => 'sessions#create', as: :sign_in
  get 'auth/:provider/callback', to: 'sessions#create_google'
  get 'auth/failure', to: redirect('/')
  delete 'log_out' => 'sessions#destroy', as: :log_out
  post 'flight_respons' => 'flights#google_api_respons', as: :flight_respons
  get 'flights/index' => 'flights#index'
  post 'hotels/search' => 'hotels#search', as: :hotels_search
end
