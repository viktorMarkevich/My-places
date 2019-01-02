class DashboardController < ApplicationController

  def index
    render json: { data: 'Hello World from backend!', status: 200 }
  end
end
