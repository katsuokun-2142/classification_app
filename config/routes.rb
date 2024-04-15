Rails.application.routes.draw do
  root "web_site_infos#index"
  resources :web_site_infos, only: [:index, :new, :create]
end
