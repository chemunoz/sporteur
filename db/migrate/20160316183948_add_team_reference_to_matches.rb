class AddTeamReferenceToMatches < ActiveRecord::Migration
  def change
    add_reference :matches, :localteam_id, references: :teams
    add_reference :matches, :visitteam_id, references: :teams
  end
end
