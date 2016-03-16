class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :tshirt_color
      t.string :address

      t.timestamps null: false
    end
  end
end
