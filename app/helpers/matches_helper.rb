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

  def voted_rival?(match, judger, rival)
    Handicap.where(match_id: match, judge: judger, voted_player: rival).exists?
  end


  def matches_user_play(user, type)
    # 0 = total matches played
    # 1 = matches wins
    # 2 = matches lose
    # 3 = total matches
    locals = 0
    visits = 0
    user.teams.each do |t|
      case type
      when 0    
        locals = locals + Match.where("(local_team_id =#{t.id} OR visit_team_id = #{t.id}) 
          AND winner IS NOT NULL AND loser IS NOT NULL").count.to_i
        # visits = visits + Match.where(visit_team_id: t.id).count.to_i
      when 1
        locals = locals + Match.where(winner: t.id).count.to_i
      when 2
        locals = locals + Match.where(loser: t.id).count.to_i
      when 3
        locals = locals + Match.where("(local_team_id =#{t.id} OR visit_team_id = #{t.id})").count.to_i
      end
    end
    total = locals + visits
  end

end
