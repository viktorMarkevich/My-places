class HomeController < ApplicationController

  def index
    p '*'*100
    render json: { data: 'Hello World from backend!', status: 200 }
  end
end
