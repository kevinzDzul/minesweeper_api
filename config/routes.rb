Rails.application.routes.draw do
  resources :games, only: [:create, :show] do
    put :pause, :resume
    post :validate, :flag
  end
  resources :api_doc, only: [:index]
end
