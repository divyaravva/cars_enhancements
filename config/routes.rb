Rails.application.routes.draw do
  match '/cars/generate_pdf' => 'cars#generate_pdf', via: :get
  match '/cars/generate_excel' => 'cars#generate_excel', via: :get
  resources :comments
  resources :cars

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'cars#index'
end
