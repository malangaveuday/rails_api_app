require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json }
  # API DEFINITION
  namespace :api, default: { format: :json },  path: '/' do
    scope module: :v1 do
      # We are going to list our resources here
      resources :users, :only => [:show, :create, :update, :destroy]
      resources :session, :only => [:create, :destroy]
    end
  end
end