class ConfirmationsController < ApplicationController
  skip_before_action :authenticate_request

  def confirm
    if token_params_present
      user = User.find_by(confirmation_token: token_params[:confirmation_token])
      if user.try(:confirmation_token_valid?)
        user.mark_as_confirmed!
        render json: { status: 'User confirmed successfully',
                       auth_token: JsonWebToken.encode(user_id: user.id) },
               status: :ok

      end || (render invalid_token)
    end || (render invalid_token)
  end

  private

  def token_params
    params.require(:token).permit(:confirmation_token)
  end

  def invalid_token
    { json: { status: 'Invalid token' }, status: :not_found }
  end

  def token_params_present
    params[:token].present? && token_params[:confirmation_token]
  end
end
