class SessionsController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      user.regenerate_auth_token if user.auth_token.nil?
      render json: { auth_token: user.auth_token }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def destroy
    current_user.invalidate_token
    render json: { message: 'Logged out successfully' }
  end
end
