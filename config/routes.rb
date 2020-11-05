Rails.application.routes.draw do
  root 'search#index'

  resources :search do
    collection do
      post :upload_file
      post :search_by_tocken
    end
  end
end
