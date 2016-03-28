module MatchesHelper

  def user_belongs_to_match?(match, user)
    match.visit.users.exists?(id:current_user.id) || 
    match.local.users.exists?(id:current_user.id)
  end

  def team_belongs_to_match?(match, team)
    match.visit.exists?(id:team.id) || 
    match.local.exists?(id:team.id)
  end
  
  # def rival_team(match, user)
  #   binding.pry
  #   match.not.teams
  # end

  def user_wins_match(match, user)
    if match.winner
      Team.find(match.winner).users.exists?(user)
    end
  end

  def user_lose_match(match, user)
    if match.loser
      Team.find(match.loser).users.exists?(user)
    end
  end

  def build_score(match)
    points = match.points
    score = ""
    points.each do |p|     
      score << "#{p.local_points}-#{p.visit_points} "
    end
    return score
  end

  def voted_rival?(match, rival)
    Handicap.where(match_id: match, voted_player: rival).exists?
  end
end
