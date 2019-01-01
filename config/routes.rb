Rails.application.routes.draw do
  root "demo#index"

  resources :subjects do
    member do
      get :delete
    end
  end

  resources :pages do
    member do
      get :delete
    end
  end

  resources :sections do
    member do
      get :delete
    end
  end

  get 'demo/index'
  get 'demo/hello'
  get 'demo/other_hello'
  get 'demo/linkedIn'
  get "demo/escape_output"
  # log way of writing of the get route
  # match "demo/index", :to =>  "demo#index", :via => :get

  # the default Route
  # get ':controller(/:action(/:id))' #or
  # match ':controller(/:demo(/:id))', :via => :get

  # the ROOT route
  # root to: 'demo#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end