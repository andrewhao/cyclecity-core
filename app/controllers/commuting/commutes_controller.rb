class Commuting::CommutesController < ApplicationController
  before_action :set_commuting_commute, only: [:show, :edit, :update, :destroy]
  before_action :ensure_logged_in

  def index
    @commuting_commutes = Commuting::Commute
      .where(strava_athlete_id: current_user.strava_athlete_id)
      .order(id: :desc)
  end

  def show
  end

  def new
    @commuting_commute = Commuting::Commute.new
  end

  def edit
  end

  def create
    @commuting_commute = Commuting::Commute.new(commuting_commute_params)

    if @commuting_commute.save
      redirect_to @commuting_commute, notice: 'Commute was successfully created.'
    else
      render :new
    end
  end

  def update
    if @commuting_commute.update(commuting_commute_params)
      redirect_to @commuting_commute, notice: 'Commute was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @commuting_commute.destroy
    redirect_to commuting_commutes_url, notice: 'Commute was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commuting_commute
      @commuting_commute = Commuting::Commute.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def commuting_commute_params
      params[:commuting_commute]
    end
end
