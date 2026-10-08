Rails.application.routes.draw do
  resources :salons
  resources :customers
  resources :appointments
  resources :services
  resources :employees
end
