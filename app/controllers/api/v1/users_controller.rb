class Api::V1::UsersController < ApplicationController 
  skip_before_action :require_login, only: [:create]

  def create
    user = User.new(user_params)
    if user.valid?
      user.save 
      payload = {user_id: user.id}
      token = encode_token(payload)
      render json: {user: user, jwt: token, success: "Welcome, #{user.first_name}"}
    else
      render json: {failure: user.errors.full_messages, jwt: ''}
    end
  end

  private

  def user_params 
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :location, :about)
  end

end