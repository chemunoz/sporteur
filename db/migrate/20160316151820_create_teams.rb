class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :tshirtcolor
      t.string :address

      t.timestamps null: false
    end
  end
end
