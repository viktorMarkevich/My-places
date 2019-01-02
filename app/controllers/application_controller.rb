class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler

  before_action :authorize_request
  attr_reader :current_user

  private

  def authorize_request
    p '*'*100
    p request.headers
    p '*'*100

    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end
end
