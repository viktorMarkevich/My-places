class DashboardsController < ApplicationController

  def index
    @trips = current_user.trips

    render json: @trips
  end
end
