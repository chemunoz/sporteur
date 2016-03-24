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
    @match = Match.find_by(id: params[:id])
    @team_local = Team.find_by(id: @match.local_team_id)
    @team_visit = Team.find_by(id: @match.visit_team_id)
  end


  def new
    @user = current_user
    @match = Match.new
    #@match = @user.matches.new
  end


  def create
   @user = User.find(current_user.id)
   create_teams
   
   @match = Match.new(match_params)
   @match.local_team_id = @local_team.id
   @match.visit_team_id = @visit_team.id
   @match.creator_id = current_user.id
   @match.places_busy = 1
   
   if @match.save
     redirect_to matches_path, notice: 'Match was successfully created.' 
   else
     render 'new'
   end
  end

  def edit
    @user = User.find(params[:user_id])
    @match = Match.find(params[:id])
  end


  def update
    @match = Match.find(params[:id])
    score2save = []
    for i in 1..5
      score2save << params["game#{i}-local"]
      score2save << params["game#{i}-visit"]
    end
    @match.update_attribute(:score, score2save.join(""))

  end


  def join
    @user = User.find(current_user.id)
    team = Team.find_by(id:params[:id])
    mat = Match.where("(local_team_id = #{team.id} OR visit_team_id = #{team.id})")
    
    
    # contador = mat.places_busy + 1
    # mat.places_busy = contador
    # mat.save

    @user.teams << team
    redirect_to matches_path, notice: 'Youre in!.' 
  end

  def score
    binding.pry
    #params
  end



  private
  def match_params
    params.require(:match).permit(:date, :score, :venue, :price, :places, :lat, :lng)
  end

  def create_teams
    @local_team = @user.teams.create
    @visit_team = Team.create
  end
end
