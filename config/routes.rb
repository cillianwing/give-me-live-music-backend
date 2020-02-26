Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post '/concerts/upcoming', to: 'concerts#upcoming'
      resource :users do
        resource :concerts
        resource :venues
      end
      post "/login", to: "auth#login"
  		get "/auto_login", to: "auth#auto_login"
  		get "/user_is_authed", to: "auth#user_is_authed"
    end
  end

end
