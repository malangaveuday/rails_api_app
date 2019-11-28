Rails.application.routes.draw do
  # API DEFINITION
  namespace :api, default: { format: :json }, constraints: { subdomain: 'api' }, path: '/' do
    # WE ARE GOING TO LIST OUR RESOURCES HERE

  end
end
