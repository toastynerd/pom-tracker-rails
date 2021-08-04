class Api::V1::SessionsController < ApplicationController
  def create
    @user = User.find_by(email: params[:email])
    if @user.authenticate(params[:password])
      render json: {token: encode_jwt(user_id: @user[:id])}
    else
      render json: @user.errors
    end
  end
end
