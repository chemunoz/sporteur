class TeamsController < ApplicationController
  def index
    @teams = Team.all
  end

  def new
    @team = Team.create
  end

  def create
    team = Team.create(team_params)
    if team.save
      redirect_to user_team_path
    else
      render 'new'
    end
  end


  private
  def team_params
    params.require(:team).permit(:name, :tshirt_color, :address)
  end
end
