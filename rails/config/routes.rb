Rails.application.routes.draw do

  devise_for :users
  root 'welcome#index'

  get '/login', to: 'sessions#new', as: :login
  get '/pages', to: 'pages#show'

  get '/leaderboard/points', to: 'activities#points'
  get '/leaderboard/workouts', to: 'activities#workouts'
  get '/leaderboard/users', to: 'activities#users'

  [:fitbit, :strava, :runkeeper, :nike, :jawbone].each do |provider|
    get "/auth/#{provider}", to: 'sessions#new', provider: provider
    post "/auth/#{provider}", to: 'sessions#create', provider: provider
  end

  match "/auth/:provider/callback", to: 'sessions#create', via: [:get, :post]
  match '/auth/failure', to: 'sessions#failure', via: [:get, :post]

  namespace :api, defaults: {format: 'json'} do
    scope :v1 do
      scope :leaderboard do
        get 'workouts', to: 'activities#workouts'
        get 'points', to: 'activities#points'
      end

      resources :users
    end
  end
end
