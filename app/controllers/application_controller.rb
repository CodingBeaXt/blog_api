class ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  def authenticate_request
    token = request.headers['Authorization']&.split(' ')&.last
    @current_user = User.find_by(auth_token: token)

    unless @current_user
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end

  attr_reader :current_user
end
