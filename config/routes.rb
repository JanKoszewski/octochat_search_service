OctochatSearchService::Application.routes.draw do
  resources :messages
  root :to => "messages#index"

  namespace :api do
    namespace :v1 do
      resources :messages
    end
  end
end
