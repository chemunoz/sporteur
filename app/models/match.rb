class Match < ActiveRecord::Base
  belongs_to :local, class_name: 'Team', foreign_key: 'local_team_id'
  belongs_to :visit, class_name: 'Team', foreign_key: 'visit_team_id'
  belongs_to :creator, class_name: 'User'
end
