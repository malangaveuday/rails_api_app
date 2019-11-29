require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users
  # API DEFINITION
  namespace :api, default: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do
      # We are going to list our resources here
    end
  end
end
