class Match < ActiveRecord::Base
  belongs_to :local, class_name: 'Team', foreign_key: 'local_team_id'
  belongs_to :visit, class_name: 'Team', foreign_key: 'visit_team_id'
  belongs_to :creator, class_name: 'User'
  has_and_belongs_to_many :users

  validates :date, presence: true
  
  
  before_save :default_values
  def default_values
    self.places ||= 4
  end

  def create
     @user = User.find(current_user.id)
     @team = @user.matches.new(team_params)
     if @team.save
       @user.teams << @team
       redirect_to action: 'index', user_id: @user.id 
     else
     render 'new'
     end
  end

  def rivals(user)
    local.users.include?(user) ? visit.users : local.users
  end

  private
  def team_params
    params.require(:match).permit(:name,:tshirtcolor,:address)
  end
end
