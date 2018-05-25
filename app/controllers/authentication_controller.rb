class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def authenticate
    user = User.find_by_email(login_params[:email])
    if user.try(:token_is_confirmed?)
      command = AuthenticateUser.call(login_params[:email], login_params[:password])
      if command.success?
        render json: { auth_token: command.result }, status: :ok
      else
        render json: { error: command.errors }, status: :unauthorized
      end
    else
      render json: { message: 'Please register or confirm your account' }, status: :unauthorized
    end
  end


  private

  def login_params
    params.require(:login).permit(:email, :password)
  end
end