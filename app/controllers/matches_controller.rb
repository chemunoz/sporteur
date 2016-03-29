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

    @comments_in_bbdd = @match.comments
    @comment = Comment.new
    # <p class="sporteur-form-control">Winner: <%= @team_local.users[0].name %></p>
    # <p class="sporteur-form-control">Loser Team: <%= @team_visit.users[0].name %></p>
    
    #PARTIAL <a href="#" class="btn <%= type %>" disabled><%= team.users[i].name %></a>
  end


  def new
    @match = Match.new
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
    binding.pry
    @match=Match.find(params[:id])
    if @match.update_attributes match_params
      redirect_to action: :index
    else
      render 'edit'
    end
  end


  def join
    @user = User.find(current_user.id)
    team = Team.find_by(id: params[:id])
    mat = Match.where("(local_team_id = #{team.id} OR visit_team_id = #{team.id})")

    if @user.teams << team
      mat.first.update_attribute(:places_busy, mat.first.places_busy+1)
      redirect_to matches_path, notice: 'Youre in!.' 
    end
    
  end

  def score
    @match = Match.find(params[:id])

    unless Point.find_by(match_id: params[:id])
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


  def handicap_rivals
    for i in 0..1
      if params["rival#{i}_id"] && params["rival#{i}_vote"]!=""
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
    redirect_to :back
  end


  def destroy

    mat = Match.find(params[:id])
    user = User.find(params[:user_id])
    team = which_team_belongs_user?(mat, user)
    team.users.delete(user)
  
    mat.first.update_attribute(:places_busy, mat.first.places_busy-1)
    redirect_to :back
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


  def which_team_belongs_user?(match, user)
    if match.local.users.exists?(user)
      return match.local
    elsif match.visit.users.exists?(user)
      return match.visit
    else
      return 0
    end
  end

end
