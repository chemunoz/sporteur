class Team < ActiveRecord::Base
  has_and_belongs_to_many :users

  def create
     @user = User.find(params[:user_id])
     @team = @user.teams.new(team_params)
     if @team.save
       @user.teams << @team
       redirect_to action: 'index', user_id: @user.id 
     else
     render 'new'
     end
   end

   private
   def team_params
    params.require(:team).permit(:name,:tshirtcolor,:address)
   end
end
