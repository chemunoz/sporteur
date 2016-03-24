module MatchesHelper
  def user_belongs_to_match?(match, user)
    match.visit.users.exists?(id:current_user.id) || 
    match.local.users.exists?(id:current_user.id)
  end

  def team_belongs_to_match?(match, team)
    match.visit.exists?(id:team.id) || 
    match.local.exists?(id:team.id)
  end
end
