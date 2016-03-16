class MatchFixColumnsNames < ActiveRecord::Migration
  def change
    rename_column :matches, :localteam_id_id, :localteam_id
    rename_column :matches, :visitteam_id_id, :visitteam_id
  end
end
