class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:create]


  def show
    render :json => User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: 201, location: [:api, user]
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
