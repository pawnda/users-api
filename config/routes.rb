Rails.application.routes.draw do
  post 'signin' => 'user_token#create'

  namespace :api do
    namespace :v1 do
      resources :users
    end
  end
end
