Rails.application.routes.draw do
  root 'search#index'

  resources :search do
    collection { post :upload_file }
  end
end
