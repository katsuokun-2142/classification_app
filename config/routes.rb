Rails.application.routes.draw do
  root "web_site_infos#index"
  resources :web_site_infos, only: [:index, :new, :create, :destroy]
  # resources :web_site_infos
  resources :categories,  only: [:index] do
    resources :web_site_infos, only: [:destroy]
  end
end
