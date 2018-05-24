class DashboardsController < ApplicationController

  def index
    @trips = Trip.all

    render json: @trips
  end
end
