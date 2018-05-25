class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def authenticate
    user = User.find_by_email(params[:email])
    if user.present? && user.token_is_confirmed?
      command = AuthenticateUser.call(params[:email], params[:password])
      if command.success?
        render json: { auth_token: command.result }
      else
        render json: { error: command.errors }, status: :unauthorized
      end
    else
      render json: { message: 'Please make registration or confirm your account' }, status: :unauthorized
    end
  end
end