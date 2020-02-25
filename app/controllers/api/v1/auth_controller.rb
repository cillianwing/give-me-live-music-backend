class Api::V1::AuthController < ApplicationController
  skip_before_action :require_login, only: [:login, :auto_login]

  def login
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      payload = {user_id: user.id}
      token = encode_token(payload)
      render json: {user: user, jwt: token, success: "Welcome back, #{user.first_name}"}
    else
      render json: {failure: "Login failed - email or password invalid!", jwt: ''}
    end
  end

  def auto_login
    if session_user
      render json: session_user
    else
      render json: {failure: "No user logged in."}
    end
  end

  def user_is_authed
    render json: {success: "You are authorized."}
  end

end