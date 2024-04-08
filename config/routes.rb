Rails.application.routes.draw do
  get "main", to: 'weathers#main'
  # get "error", to: 'weathers#error'
  get "forecast", to: 'weathers#forecast'
  get "index", to: 'things#index'
  get "all", to: 'weathers#pre_json'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root 'weathers#main'
end
