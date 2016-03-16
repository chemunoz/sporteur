class Match < ActiveRecord::Base
  belongs_to :local, :class_name => 'Team', :foreign_key => 'localteam_id'
  belongs_to :visit, :class_name => 'Team', :foreign_key => 'visitteam_id'
end
