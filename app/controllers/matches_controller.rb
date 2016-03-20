class MatchesController < ApplicationController
  # before_action :create_teams, only: [:create]

  def index
    if params[:user_id]
      @matches = Match.where(creator_id: params[:user_id]).order(date: :desc)
    else
      @matches = Match.all
    end
  end

  def show
    # @players_local = nil
    # @players_visit = nil

    @match = Match.find_by(id: params[:id])
    @team_local = Team.find_by(id: @match.local_team_id)
    @team_visit = Team.find_by(id: @match.visit_team_id)

    # @players_local = @team_local.users
    # @players_visit = @team_visit.users
    

    # while @players_local.count < (@match.places/2)
    #   @players_local << @team_local.users[i]
    #   i++
    # end
    
    # if @team_local
    #   @players_local = @team_local.users
    # end
    # if @team_visit
    #   @players_visit = @team_visit.users
    # end
    
    # @players = @match.users
    
    
  end

  def new
    @user = current_user
    #@match = Match.new
    @match = @user.matches.new
  end

  def create
   @user = User.find(current_user.id)
   create_teams
   # @match = @user.matches.new(match_params)
   @match = Match.new(match_params)
   @match.local_team_id = @local_team.id
   @match.visit_team_id = @visit_team.id
   @match.creator_id = current_user.id
   @match.places_busy = 1
   
   if @match.save
     # @user.matches << @match 
     #redirect_to action: 'index', user_id: @user.id 
     redirect_to matches_path, notice: 'Match was successfully created.' 
   else
     render 'new'
   end
  end

  def join

  end


  private
  def match_params
    params.require(:match).permit(:date, :score, :venue, :price, :places)
  end

  def create_teams
    @local_team = @user.teams.create
    @visit_team = Team.create
  end
end
