Rails.application.routes.draw do
  root 'static_pages#index'
  get '/help', to: 'static_pages#help'
end
