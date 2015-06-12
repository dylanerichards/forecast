Rails.application.routes.draw do
  root "locations#new"
  resources :locations

  get 'pages/index'
end
