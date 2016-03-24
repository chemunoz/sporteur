class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.references :local_team, references: :teams
      t.references :visit_team, references: :teams
      t.references :creator, reference: :users

      t.string :score
      t.datetime :date
      t.string :venue
      t.string :lat
      t.string :lng
      t.float :price
      t.integer :winner
      t.integer :loser
      t.integer :places
      t.integer :places_busy, default: 0

      t.timestamps null: false
    end
  end
end
