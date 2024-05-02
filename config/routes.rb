Rails.application.routes.draw do
  scope "/api" do
    get "up" => "rails/health#show", as: :rails_health_check

    post "users" => "users#create"

    post "login" => "sessions#create"

    get "me" => "users#me"

    get "polls" => "polls#index"
    post "polls/vote" => "votes#create"

    get "polls/:id" => "polls#show", constraints: { id: /\d+/ }

    post "polls" => "polls#create"
  end
end
