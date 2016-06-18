class StoplightsController < ApplicationController
  def index
    render json: Commuting::StopEventCluster.all
  end

  def show
    render json: Commuting::StopEventCluster.first
  end
end
