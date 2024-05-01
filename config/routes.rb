Rails.application.routes.draw do
  scope "/api" do
    get "up" => "rails/health#show", as: :rails_health_check

    post "users" => "users#create"

    post "login" => "sessions#create"

    get "me" => "users#me"
  end
end
