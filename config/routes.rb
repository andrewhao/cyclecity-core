VelocitasCore::Application.routes.draw do
  resources :tracks
  root to: 'pages#root'
  mount VelocitasCore::TracksAPI => '/api'
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
end
