Rails.application.routes.draw do
  scope module: "authentication" do
    # Sessions controller
    get "sign-in", to: "sessions#new", as: :sign_in
    post "sign-in", to: "sessions#create"
    delete "sign-out", to: "sessions#destroy", as: :sign_out
  end

  get "private", to: "private#index"

  # Defines the root path route ("/")
  root "public#index"
end
