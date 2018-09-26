class HomeController < ApplicationController

  def index
    render json: { data: 'Hello World!', status: 200}
  end
end
