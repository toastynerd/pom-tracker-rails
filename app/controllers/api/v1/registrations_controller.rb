class Api::V1::RegistrationsController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      render json: {token: encode_jwt(@user)}
    else
      render json: @user.errors
    end
  end

  private
  def user_params
    params.permit(:email, :password, :password_confirmation)
  end
end
