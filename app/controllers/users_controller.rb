class UsersController < ApplicationController

  def index
    @users = User.all.order(name: :asc)
  end


  def show
    @user = User.find(params[:id])
    if current_user
      @user.teams.each do |tm|
        # @user_matches = Match.where("(local_team_id = #{tm.id} OR visit_team_id = #{tm.id}) AND creator_id = #{current_user.id}")
        # @user_matches = Match.where("creator_id = #{current_user.id}").order(date: :asc)
         @user_matches = Match.order(date: :asc)
      end
    end
  end

  def rankings
    @users_ntrp = User.all.order(ntrp: :desc).limit(5)
    @users_recents = User.all.order(created_at: :desc).limit(5)
  end

  # User.group(:ntrp).count
end
