class RegistrationsController < ApplicationController
  skip_before_action :authenticate_request

  def create
    user = User.new(user_params)
    if user.save
      render json: { status: 'User created successfully' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end


  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end
end