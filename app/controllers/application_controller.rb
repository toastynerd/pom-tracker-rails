class ApplicationController < ActionController::Base

  def encode_jwt(payload)
    JWT.encode(payload, Rails.configuration.jwt_secret)
  end

  def auth_header
    request.headers['Authorization']
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, Rails.configuration.jwt_secret, true, algorith: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  def current_user
    if decoded_token
      user_id = decoded_token[0]['user_id']
      @user = User.find(user_id)
    end
  end

  def logged_in?
    !!current_user
  end

  def authenticated_user
    render json: {message: 'log in required'}, status: :unauthorized unless logged_in?
  end
end
