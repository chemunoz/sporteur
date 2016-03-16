class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.references :local_team, references: :teams
      t.references :visit_team, references: :teams
      t.references :creator, reference: :users
      t.string :score
      t.datetime :date

      t.timestamps null: false
    end
  end
end