class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def authenticate
    command = AuthenticateUser.call(login_params[:email], login_params[:password])
    if command.success?
      render json: { auth_token: command.result }, status: :ok
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  private

  def login_params
    params.require(:login).permit(:email, :password)
  end
end