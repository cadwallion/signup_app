SignupApp::Application.routes.draw do
  resources :accounts do
    collection do
      post :search
    end
  end
  
  root :to => "accounts#new"
end
