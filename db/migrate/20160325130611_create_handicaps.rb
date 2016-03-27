class CreateHandicaps < ActiveRecord::Migration
  def change
    create_table :handicaps do |t|
      t.belongs_to :match, index: true
      t.integer :judge
      t.integer :voted_player
      t.float :vote

      t.timestamps null: false
    end
  end
end
