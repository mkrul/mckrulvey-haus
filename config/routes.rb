Rails.application.routes.draw do
  root "dashboard#index"

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :pantry do
    root "dashboard#index", as: :root
  end
  get "pantry", to: redirect("/pantry"), as: :pantry

  namespace :animals do
    root "dashboard#index", as: :root
  end
  get "animals", to: redirect("/animals"), as: :animals

  namespace :rabbitry do
    root "dashboard#index", as: :root
  end
  get "rabbitry", to: redirect("/rabbitry"), as: :rabbitry

  namespace :freezer do
    root "dashboard#index", as: :root
    resources :freezers
    resources :items do
      member do
        get :duplicate
      end
    end
  end
  get "freezer", to: redirect("/freezer"), as: :freezer

  resources :phone_numbers, only: [:index, :new, :create, :destroy]
  resources :scheduled_tasks, only: [:index, :new, :create, :edit, :update, :destroy]
end
