Rails.application.routes.draw do
  scope "/api" do
    get "up" => "rails/health#show", as: :rails_health_check

    post "users" => "users#create"

    post "login" => "sessions#create"

    get "me" => "users#me"

    get "polls" => "polls#index"
    post "polls/:poll_id/vote" => "votes#create", constraints: { poll_id: /\d+/ }

    get "polls/:id" => "polls#show", constraints: { id: /\d+/ }

    post "polls" => "polls#create"
    delete "polls/:id" => "polls#destroy", constraints: { id: /\d+/ }
  end
end
