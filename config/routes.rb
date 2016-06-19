VelocitasCore::Application.routes.draw do
  resources :tracks
  resources :stoplights, only: [:index, :show]
  scope module: :commuting do
    resources :commutes
  end

  root to: 'pages#root'
  mount Commuting::ActivitiesAPI => '/api'
  mount Commuting::StoplightAPI => '/api'
  mount VelocitasCore::TracksAPI => '/api'
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
end
