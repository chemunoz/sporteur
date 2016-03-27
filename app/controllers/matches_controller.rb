class MatchesController < ApplicationController
  # before_action :create_teams, only: [:create]

  def index
    if params[:user_id]
      @matches = Match.where(creator_id: params[:user_id]).order(date: :asc)
    else
      @matches = Match.all.where('date > ?', DateTime.now).order(date: :asc)
    end
  end


  def show
    @match = Match.find_by(id: params[:id])
    @team_local = Team.find_by(id: @match.local_team_id)
    @team_visit = Team.find_by(id: @match.visit_team_id)

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

    if @user.teams << team
      mat.first.update_attribute(:places_busy, mat.first.places_busy+1)
      redirect_to matches_path, notice: 'Youre in!.' 
    end
    
  end

  def score
    binding.pry
    #params
  end

  def handicap_rivals
    # {"match_id"=>"1", "rival0_id"=>"2", "rival0_vote"=>"", "rival1_id"=>"4", "rival1_vote"=>"", "controller"=>"matches", "action"=>"handicap_rivals", "id"=>"1"}
    for i in 0..1
      if params["rival#{i}_id"]
        hand = Handicap.new
        hand.match_id = params['match_id']
        hand.judge = params['judge']
        hand.voted_player = params["rival#{i}_id"]
        hand.vote = params["rival#{i}_vote"]
        hand.save

        player = User.find(params["rival#{i}_id"])
        array = Handicap.where("voted_player = #{params["rival#{i}_id"]}")
        player.ntrp = array.average(:vote).to_f.round(2)
        player.save
      end
    end
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
