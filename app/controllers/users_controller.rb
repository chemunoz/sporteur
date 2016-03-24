class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    if current_user
      @user.teams.each do |tm|
        # @user_matches = Match.where("(local_team_id = #{tm.id} OR visit_team_id = #{tm.id}) AND creator_id = #{current_user.id}")
        @user_matches = Match.where("creator_id = #{current_user.id}")
      end
    end
  end
end
