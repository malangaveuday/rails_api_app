class ApplicationController < ActionController::API
  respond_to :json
  include ActionController::RequestForgeryProtection
  protect_from_forgery prepend: true

  include Authenticable
end
