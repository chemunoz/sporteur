class MatchesController < ApplicationController
  # before_action :create_teams, only: [:create]

  def index
    if params[:user_id]
      @matches = Match.where(creator_id: params[:user_id]).order(date: :asc)
    else
      @matches = Match.all.order(date: :asc)
    end
  end

  def show
    @match = Match.find_by(id: params[:id])
    @team_local = Team.find_by(id: @match.local_team_id)
    @team_visit = Team.find_by(id: @match.visit_team_id)
    #How many players there are in this match = show it in show view

    # <p class="sporteur-form-control">Winner: <%= @team_local.users[0].name %></p>
    # <p class="sporteur-form-control">Loser Team: <%= @team_visit.users[0].name %></p>
    
    #PARTIAL <a href="#" class="btn <%= type %>" disabled><%= team.users[i].name %></a>
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

    unless Point.find_by(match_id: params[:id])
      #Each set
      for i in 1..5
        points = Point.new
        points.match_id = @match.id
        points.order = i
        points.local_points = params["game#{i}-local"]
        points.visit_points = params["game#{i}-visit"]
        points.save
      end
    else
      for i in 1..5
        binding.pry
        p = Point.where(match_id: params[:id], order: i)
        p[0].update_attribute(:local_points, params["game#{i}-local"])
        p[0].update_attribute(:visit_points, params["game#{i}-visit"])
      end
    end
    who_wins(params)  
  end




  def join
    @user = User.find(current_user.id)
    team = Team.find_by(id:params[:id])
    mat = Match.where("(local_team_id = #{team.id} OR visit_team_id = #{team.id})")

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

  def who_wins(params)
    win_lose = 0

    for i in 1..5
      win_lose += params["game#{i}-local"]<=>params["game#{i}-visit"]
    end
    
    m = Match.find(params[:id])
    if win_lose>0
      m.winner = m.local_team_id
      m.loser = m.visit_team_id
    else
      m.winner = m.visit_team_id
      m.loser = m.local_team_id
    end
    m.save
  end
end
